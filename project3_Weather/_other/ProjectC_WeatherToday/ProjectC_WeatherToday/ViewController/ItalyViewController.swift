//
//  ItalyViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/03.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - ItalyViewController
/// 화면 2 부분 -> 이탈리아
class ItalyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let italyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.weatherListCellIdentifier)
        tableView.rowHeight = CGFloat(150)
        return tableView
    }()
    
    private let italyWeatherImage: WeatherImageData = {
        let weatherImage = WeatherImageData()
        return weatherImage
    }()
    
    var italyWeatherDatas: [WeatherData] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        italyTableView.delegate = self
        italyTableView.dataSource = self
        
        self.title = "이탈리아"
        
        decodeWeatherData()
        setupNaviController(self: self)
        setupItalyTableView()
    }
    
    private func setupItalyTableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(italyTableView)
        
        italyTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            italyTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            italyTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            italyTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            italyTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func getItalyWeatherDatas(cell: WeatherListCell, italyWeather: WeatherData) {
        
        cell.cityName.text = italyWeather.cityName
        cell.temperature.text = italyWeather.celsiusAndFahrenheit
        cell.rainfallProbability.text = italyWeather.percentageOfrainfall
        
        switch italyWeather.state {
        case 10:
            cell.weatherImageView.image = italyWeatherImage.sunny
        case 11:
            cell.weatherImageView.image = italyWeatherImage.cloudy
        case 12:
            cell.weatherImageView.image = italyWeatherImage.rainy
        case 13:
            cell.weatherImageView.image = italyWeatherImage.snowy
        default:
            print("Error: Can't find match Italy weather state and Italy weather image")
        }
    }
    
    private func dataTransfer(weatherDetailVC: WeatherDetailViewController, cellDatas: WeatherData) {
        
        weatherDetailVC.cityName = cellDatas.cityName
        weatherDetailVC.rainfall = cellDatas.percentageOfrainfall
        weatherDetailVC.temp = cellDatas.celsiusAndFahrenheit
        
        switch cellDatas.state {
        case 10:
            weatherDetailVC.weatherImage = italyWeatherImage.sunny
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 11:
            weatherDetailVC.weatherImage = italyWeatherImage.cloudy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 12:
            weatherDetailVC.weatherImage = italyWeatherImage.rainy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 13:
            weatherDetailVC.weatherImage = italyWeatherImage.snowy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        default:
            print("Error: Can't find match Italy weather state and Italy weather image")
        }
    }
    
    private func decodeWeatherData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "it") else {
            return
        }
        
        do {
            italyWeatherDatas = try jsonDecoder.decode([WeatherData].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return italyWeatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return UITableViewCell()
        }
        
        let cellDatas: WeatherData = italyWeatherDatas[indexPath.row]
        
        getItalyWeatherDatas(cell: cell, italyWeather: cellDatas)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellDatas: WeatherData = italyWeatherDatas[indexPath.row]
        
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
