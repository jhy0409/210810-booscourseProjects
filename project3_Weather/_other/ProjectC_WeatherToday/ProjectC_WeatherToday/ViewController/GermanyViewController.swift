//
//  GermanyViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/03.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - GermanyViewController
/// 화면 2 부분 -> 독일
class GermanyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let germanyTableView: UITableView = {
        let tableView: UITableView = UITableView()
        tableView.register(WeatherListCell.self, forCellReuseIdentifier: WeatherListCell.weatherListCellIdentifier)
        tableView.rowHeight = CGFloat(150)
        return tableView
    }()
    
    private let weatherImage: WeatherImageData = {
       let weatherImage = WeatherImageData()
        return weatherImage
    }()
    
    var weatherDatas: [WeatherData] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        
        germanyTableView.delegate = self
        germanyTableView.dataSource = self
        
        
        self.title = "독일"
        
        setupNaviController(self: self)
        
        setupGerTableView()
        decodeWeatherData()
    }
    
    private func setupGerTableView() {
        let guide = self.view.safeAreaLayoutGuide
        
        view.addSubview(germanyTableView)
        
        germanyTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            germanyTableView.topAnchor.constraint(equalTo: guide.topAnchor),
            germanyTableView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            germanyTableView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            germanyTableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return UITableViewCell()
        }
        
        let cellDatas: WeatherData = weatherDatas[indexPath.row]
        
        getGerWeatherDatas(cell: cell, germanyWeather: cellDatas)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cellDatas: WeatherData = weatherDatas[indexPath.row]
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: WeatherListCell.weatherListCellIdentifier, for: indexPath) as? WeatherListCell else {
            return
        }
        
        if cell.isSelected == false {
            let weatherDetailVC = WeatherDetailViewController()
            
            dataTransfer(weatherDetailVC: weatherDetailVC, cellDatas: cellDatas)
            
            navigationController?.pushViewController(weatherDetailVC, animated: true)
        }
    }
    
    private func getGerWeatherDatas(cell: WeatherListCell, germanyWeather: WeatherData) {

        cell.cityName.text = germanyWeather.cityName
        cell.temperature.text = germanyWeather.celsiusAndFahrenheit
        cell.rainfallProbability.text = germanyWeather.percentageOfrainfall
        
        switch germanyWeather.state {
        case 10:
            cell.weatherImageView.image = weatherImage.sunny
        case 11:
            cell.weatherImageView.image = weatherImage.cloudy
        case 12:
            cell.weatherImageView.image = weatherImage.rainy
        case 13:
            cell.weatherImageView.image = weatherImage.snowy
        default:
            print("Error: Can't find match state and weather")
        }
    }
    
    private func dataTransfer(weatherDetailVC: WeatherDetailViewController, cellDatas: WeatherData) {
        
        weatherDetailVC.cityName = cellDatas.cityName
        weatherDetailVC.rainfall = cellDatas.percentageOfrainfall
        weatherDetailVC.temp = cellDatas.celsiusAndFahrenheit
        
        switch cellDatas.state {
        case 10:
            weatherDetailVC.weatherImage = weatherImage.sunny
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 11:
            weatherDetailVC.weatherImage = weatherImage.cloudy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 12:
            weatherDetailVC.weatherImage = weatherImage.rainy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        case 13:
            weatherDetailVC.weatherImage = weatherImage.snowy
            weatherDetailVC.stateToKr = cellDatas.weatherStateNumToKr
        default:
            print("Error: Can't find match state and weather")
        }
        
    }

    
    private func decodeWeatherData() {
        let jsonDecoder: JSONDecoder = JSONDecoder()
        guard let dataAsset: NSDataAsset = NSDataAsset(name: "de") else {
            return
        }
        
        do {
            weatherDatas = try jsonDecoder.decode([WeatherData].self, from: dataAsset.data)
        } catch {
            print(error.localizedDescription)
        }
    }

}
