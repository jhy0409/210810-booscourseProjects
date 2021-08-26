//
//  KoreaViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/03.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - KoreaViewController
/// 화면 2 부분 -> 한국
class KoreaViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let koreaTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.weatherListCellIdentifier)
        tableView.rowHeight = CGFloat(150)
        tableView.backgroundColor = .brown
        
        return tableView
    }()

    private let koreaWeatherImage: WeatherImageData = {
        let weatherImage = WeatherImageData()
        return weatherImage
    }()
    
    var koreaWeatherDatas: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        koreaTableView.delegate = self
        koreaTableView.dataSource = self
        
        self.title = "한국"
        
        decodeWeatherData()
        setupNaviController(self: self)
        setupKorTableView()
    }

    private func setupKorTableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(koreaTableView)
        
        koreaTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            koreaTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            koreaTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            koreaTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            koreaTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func getKorWeatherDatas(cell: WeatherListCell, koreaWeather: WeatherData) {

        cell.cityName.text = koreaWeather.cityName
        cell.temperature.text = koreaWeather.celsiusAndFahrenheit
        cell.rainfallProbability.text = koreaWeather.percentageOfrainfall
        
        switch koreaWeather.state {
        case 10:
            cell.weatherImageView.image = koreaWeatherImage.sunny
        case 11:
            cell.weatherImageView.image = koreaWeatherImage.cloudy
        case 12:
            cell.weatherImageView.image = koreaWeatherImage.rainy
        case 13:
            cell.weatherImageView.image = koreaWeatherImage.snowy
        default:
            print("Error: Can't find match korea weather state and korea weather image")
        }
    }
    
    private func dataTransfer(weatherDetailVC: WeatherDetailViewController, cellDatas: WeatherData) {
        
        weatherDetailVC.cityName = cellDatas.cityName
        weatherDetailVC.rainfall = cellDatas.percentageOfrainfall
        weatherDetailVC.temp = cellDatas.celsiusAndFahrenheit
        
        switch cellDatas.state {
        case 10:
            weatherDetailVC.weatherImage = koreaWeatherImage.sunny
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 11:
            weatherDetailVC.weatherImage = koreaWeatherImage.cloudy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 12:
            weatherDetailVC.weatherImage = koreaWeatherImage.rainy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 13:
            weatherDetailVC.weatherImage = koreaWeatherImage.snowy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        default:
            print("Error: Can't find match state and weather")
        }
    }
    
    private func decodeWeatherData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "kr") else {
            return
        }
        
        do {
            koreaWeatherDatas = try jsonDecoder.decode([WeatherData].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return koreaWeatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return UITableViewCell()
        }
        
        let cellDatas: WeatherData = koreaWeatherDatas[indexPath.row]
        
        getKorWeatherDatas(cell: cell, koreaWeather: cellDatas)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellDatas: WeatherData = koreaWeatherDatas[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
                   return
               }
        
        if cell.isSelected == false {
            let weatherDetailVC = WeatherDetailViewController()
            
            dataTransfer(weatherDetailVC: weatherDetailVC, cellDatas: cellDatas)
            
            navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
}
