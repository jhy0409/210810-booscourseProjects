//
//  KoreaTableViewCell.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/03.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import UIKit
// MARK: - WeatherListCell
/// 화면 2 부분 셀
class WeatherListCell: UITableViewCell {
    
    static let weatherListCellIdentifier: String = "weatherListCellIdentifier"
    
    let weatherImageView: UIImageView = {
        let imageView: UIImageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let cityName: UILabel = {
        let cityNameLabel: UILabel = UILabel()
        return cityNameLabel
    }()
    
    let temperature: UILabel = {
        let temperatureLabel: UILabel = UILabel()
        return temperatureLabel
    }()
    
    let rainfallProbability: UILabel = {
        let rainfallLabel: UILabel = UILabel()
        return rainfallLabel
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected == false {
            self.selectionStyle = .gray
        } else {
            self.selectionStyle = .none
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        setImageConstraint()
        setCityNameConstraint()
        setTemperatureConstraint()
        setRainfallProbability()
        
        self.accessoryType = .disclosureIndicator
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func setImageConstraint() {
        contentView.addSubview(weatherImageView)
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            weatherImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            weatherImageView.widthAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setCityNameConstraint() {
        contentView.addSubview(cityName)
        cityName.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cityName.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            cityName.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 15),
            cityName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cityName.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setTemperatureConstraint() {
        contentView.addSubview(temperature)
        temperature.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            temperature.topAnchor.constraint(equalTo: cityName.bottomAnchor, constant: 15),
            temperature.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 15),
            temperature.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            temperature.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    private func setRainfallProbability() {
        contentView.addSubview(rainfallProbability)
        rainfallProbability.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            rainfallProbability.topAnchor.constraint(equalTo: temperature.bottomAnchor, constant: 15),
            rainfallProbability.leadingAnchor.constraint(equalTo: weatherImageView.trailingAnchor, constant: 15),
            rainfallProbability.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            rainfallProbability.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
}
