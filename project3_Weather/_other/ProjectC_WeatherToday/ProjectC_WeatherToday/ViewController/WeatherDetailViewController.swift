//
//  WeatherDetailViewController.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/04.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - WeatherDetailViewController
/// 화면 3 뷰컨트롤러
class WeatherDetailViewController: UIViewController {
    
    private let mainView: WeatherDetailView = {
        let mainView: WeatherDetailView = WeatherDetailView()
        return mainView
    }()
    
    var temp: String = ""
    var rainfall: String = ""
    var weatherImage: UIImage = UIImage()
    var stateToKr: String = ""
    var cityName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.title = cityName
        setMainViewConstraint()
        confirmGetData()
        inputCellDatas()
    }
    
    func confirmGetData() {
        print("Success Get Data: CityName: \(cityName) Temperature : \(temp), rainfallProbability : \(rainfall), weatherImg : \(weatherImage), weatherStateToKr: \(stateToKr)")
    }
    
    private func setMainViewConstraint() {
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(mainView)
        
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: guide.topAnchor),
            mainView.leadingAnchor.constraint(equalTo: guide.leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: guide.trailingAnchor),
            mainView.bottomAnchor.constraint(equalTo: guide.bottomAnchor),
        ])
    }
    
    private func inputCellDatas() {
        mainView.mainImageView.image = weatherImage
        mainView.temperatureTitle.text = temp
        mainView.rainfallProbabilityTitle.text = rainfall
        mainView.weatherTitle.text = stateToKr
    }

}
