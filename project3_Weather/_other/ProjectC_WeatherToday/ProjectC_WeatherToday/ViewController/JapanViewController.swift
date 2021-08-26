//
//  JapanViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/03.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - JapanViewController
/// 화면 2 부분 -> 일본
class JapanViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let japanTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.weatherListCellIdentifier)
        tableView.rowHeight = CGFloat(150)
        return tableView
    }()
    
    private let japanWeatherImage: WeatherImageData = {
        let weatherImage = WeatherImageData()
        return weatherImage
    }()
    
    var japanWeatherDatas: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        japanTableView.delegate = self
        japanTableView.dataSource = self
        
        self.title = "일본"
        
        decodeWeatherData()
        setupNaviController(self: self)
        setupJapanTableView()
    }
    
    private func setupJapanTableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(japanTableView)
        
        japanTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            japanTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            japanTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            japanTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            japanTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func getJapanWeatherDatas(cell: WeatherListCell, japanWeather: WeatherData) {
        
        cell.cityName.text = japanWeather.cityName
        cell.temperature.text = japanWeather.celsiusAndFahrenheit
        cell.rainfallProbability.text = japanWeather.percentageOfrainfall
        
        switch japanWeather.state {
        case 10:
            cell.weatherImageView.image = japanWeatherImage.sunny
        case 11:
            cell.weatherImageView.image = japanWeatherImage.cloudy
        case 12:
            cell.weatherImageView.image = japanWeatherImage.rainy
        case 13:
            cell.weatherImageView.image = japanWeatherImage.snowy
        default:
            print("Error: Can't find match Japan weather state and Japan weather image")
        }
    }
    
    private func dataTransfer(weatherDetailVC: WeatherDetailViewController, cellDatas: WeatherData) {
        
        weatherDetailVC.cityName = cellDatas.cityName
        weatherDetailVC.rainfall = cellDatas.percentageOfrainfall
        weatherDetailVC.temp = cellDatas.celsiusAndFahrenheit
        
        switch cellDatas.state {
        case 10:
            weatherDetailVC.weatherImage = japanWeatherImage.sunny
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 11:
            weatherDetailVC.weatherImage = japanWeatherImage.cloudy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 12:
            weatherDetailVC.weatherImage = japanWeatherImage.rainy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 13:
            weatherDetailVC.weatherImage = japanWeatherImage.snowy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        default:
            print("Error: Can't find match Japan weather state and Japan weather image")
        }
    }
    
    private func decodeWeatherData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "jp") else {
            return
        }
        
        do {
            japanWeatherDatas = try jsonDecoder.decode([WeatherData].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return japanWeatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return UITableViewCell()
        }
        
        let cellDatas: WeatherData = japanWeatherDatas[indexPath.row]
        
        getJapanWeatherDatas(cell: cell, japanWeather: cellDatas)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellDatas: WeatherData = japanWeatherDatas[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell
            .weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return
        }
        
        if cell.isSelected == false {
            let weatherDetailVC = WeatherDetailViewController()
            dataTransfer(weatherDetailVC: weatherDetailVC, cellDatas: cellDatas)
            navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }

    
    
    
}
