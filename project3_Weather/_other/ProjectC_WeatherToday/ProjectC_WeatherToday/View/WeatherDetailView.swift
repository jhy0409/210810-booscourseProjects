//
//  WeatherDetailView.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/04.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - WeatherDetailView
/// 화면 3 부분 뷰
class WeatherDetailView: UIView {
    
    let mainImageView: UIImageView = {
        let mainImageView: UIImageView = UIImageView()
        mainImageView.contentMode = UIView.ContentMode.scaleAspectFit

        
        return mainImageView
    }()
    
    let weatherTitle: UILabel = {
        let weatherTitleLabel: UILabel = UILabel()
        weatherTitleLabel.textAlignment = .center
        return weatherTitleLabel
    }()
    
    let temperatureTitle: UILabel = {
        let temperatureLabel: UILabel = UILabel()
        return temperatureLabel
    }()
    
    let rainfallProbabilityTitle: UILabel = {
        let rainfallProbabilityLabel: UILabel = UILabel()
        return rainfallProbabilityLabel
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMainImageViewConstraint()
        setWeatherTitleConstraint()
        setTemperatureTitleConstraint()
        setRainfallProbabilityTitleConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setMainImageViewConstraint() {
        let guide = self.safeAreaLayoutGuide
        
        self.addSubview(mainImageView)
        
        mainImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: guide.topAnchor),
            mainImageView.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            mainImageView.widthAnchor.constraint(equalToConstant: 100),
            mainImageView.heightAnchor.constraint(equalToConstant: 150),
        ])
    }
    
    private func setWeatherTitleConstraint() {
        let guide = self.safeAreaLayoutGuide
        
        self.addSubview(weatherTitle)
        
        weatherTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weatherTitle.topAnchor.constraint(equalTo: mainImageView.bottomAnchor, constant: 10),
            weatherTitle.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            weatherTitle.widthAnchor.constraint(equalToConstant: 50),
            weatherTitle.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setTemperatureTitleConstraint() {
        let guide = self.safeAreaLayoutGuide
        
        self.addSubview(temperatureTitle)
        
        temperatureTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            temperatureTitle.topAnchor.constraint(equalTo: weatherTitle.bottomAnchor, constant: 10),
            temperatureTitle.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            temperatureTitle.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setRainfallProbabilityTitleConstraint() {
        let guide = self.safeAreaLayoutGuide
        
        self.addSubview(rainfallProbabilityTitle)
        
        rainfallProbabilityTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rainfallProbabilityTitle.topAnchor.constraint(equalTo: temperatureTitle.bottomAnchor, constant: 10),
            rainfallProbabilityTitle.centerXAnchor.constraint(equalTo: guide.centerXAnchor),
            rainfallProbabilityTitle.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
}
