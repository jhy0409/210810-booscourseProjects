//
//  FranceViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/03.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - FranceViewController
/// 화면 2 부분 -> 프랑스
class FranceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let franceTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.weatherListCellIdentifier)
        tableView.rowHeight = CGFloat(150)
        return tableView
    }()
    
    private let franceWeatherImage: WeatherImageData = {
        let weatherImage = WeatherImageData()
        return weatherImage
    }()
    
    var franceWeatherDatas: [WeatherData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        franceTableView.delegate = self
        franceTableView.dataSource = self
        
        self.title = "프랑스"
        
        decodeWeatherData()
        setupNaviController(self: self)
        setupFranceTableView()
    }
    
    private func setupFranceTableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(franceTableView)
        
        franceTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            franceTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            franceTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            franceTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            franceTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func getFranceWeatherDatas(cell: WeatherListCell, franceWeather: WeatherData) {
        
        cell.cityName.text = franceWeather.cityName
        cell.temperature.text = franceWeather.celsiusAndFahrenheit
        cell.rainfallProbability.text = franceWeather.percentageOfrainfall
        
        switch franceWeather.state {
        case 10:
            cell.weatherImageView.image = franceWeatherImage.sunny
        case 11:
            cell.weatherImageView.image = franceWeatherImage.cloudy
        case 12:
            cell.weatherImageView.image = franceWeatherImage.rainy
        case 13:
            cell.weatherImageView.image = franceWeatherImage.snowy
        default:
            print("Error: Can't find match France weather state and France weather image")
        }
    }
    
    private func dataTransfer(weatherDetailVC: WeatherDetailViewController, cellDatas: WeatherData) {
        
        weatherDetailVC.cityName = cellDatas.cityName
        weatherDetailVC.rainfall = cellDatas.percentageOfrainfall
        weatherDetailVC.temp = cellDatas.celsiusAndFahrenheit
        
        switch cellDatas.state {
        case 10:
            weatherDetailVC.weatherImage = franceWeatherImage.sunny
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 11:
            weatherDetailVC.weatherImage = franceWeatherImage.cloudy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 12:
            weatherDetailVC.weatherImage = franceWeatherImage.rainy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 13:
            weatherDetailVC.weatherImage = franceWeatherImage.snowy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        default:
            print("Error: Can't find match France weather state and France weather image")
        }
    }
    
    private func decodeWeatherData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "fr") else {
            return
        }
        
        do {
            franceWeatherDatas = try jsonDecoder.decode([WeatherData].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return franceWeatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return UITableViewCell()
        }
        
        let cellDatas: WeatherData = franceWeatherDatas[indexPath.row]
        
        getFranceWeatherDatas(cell: cell, franceWeather: cellDatas)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellDatas: WeatherData = franceWeatherDatas[indexPath.row]
        
        
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
