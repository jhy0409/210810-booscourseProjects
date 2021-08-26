//
//  USAViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/03.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - USAViewController
/// 화면 2 부분 -> 미국
class USAViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let usaTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.weatherListCellIdentifier)
        tableView.rowHeight = CGFloat(150)
        return tableView
    }()
    
    private let usaWeatherImage: WeatherImageData = {
        let weatherImage = WeatherImageData()
        return weatherImage
    }()
    
    var usaWeatherDatas: [WeatherData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        usaTableView.delegate = self
        usaTableView.dataSource = self
        
        self.title = "미국"
        
        decodeWeatherData()
        setupNaviController(self: self)
        setupUSATableView()
    }
    
    private func setupUSATableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(usaTableView)
        
        usaTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            usaTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            usaTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            usaTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            usaTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func getUSAWeatherDatas(cell: WeatherListCell, usaWeather: WeatherData) {
        
        cell.cityName.text = usaWeather.cityName
        cell.temperature.text = usaWeather.celsiusAndFahrenheit
        cell.rainfallProbability.text = usaWeather.percentageOfrainfall
        
        switch usaWeather.state {
        case 10:
            cell.weatherImageView.image = usaWeatherImage.sunny
        case 11:
            cell.weatherImageView.image = usaWeatherImage.cloudy
        case 12:
            cell.weatherImageView.image = usaWeatherImage.rainy
        case 13:
            cell.weatherImageView.image = usaWeatherImage.snowy
        default:
            print("Error: Can't find match USA weather state and USA weather image")
        }
    }
    
    private func dataTransfer(weatherDetailVC: WeatherDetailViewController, cellDatas: WeatherData) {
        
        weatherDetailVC.cityName = cellDatas.cityName
        weatherDetailVC.rainfall = cellDatas.percentageOfrainfall
        weatherDetailVC.temp = cellDatas.celsiusAndFahrenheit
        
        switch cellDatas.state {
        case 10:
            weatherDetailVC.weatherImage = usaWeatherImage.sunny
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 11:
            weatherDetailVC.weatherImage = usaWeatherImage.cloudy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 12:
            weatherDetailVC.weatherImage = usaWeatherImage.rainy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 13:
            weatherDetailVC.weatherImage = usaWeatherImage.snowy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        default:
            print("Error: Can't find match USA weather state and USA weather image")
        }
    }
    
    private func decodeWeatherData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "us") else {
            return
        }
        
        do {
            usaWeatherDatas = try jsonDecoder.decode([WeatherData].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usaWeatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return UITableViewCell()
        }
        
        let cellDatas: WeatherData = usaWeatherDatas[indexPath.row]
        
        getUSAWeatherDatas(cell: cell, usaWeather: cellDatas)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellDatas: WeatherData = usaWeatherDatas[indexPath.row]
        
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
