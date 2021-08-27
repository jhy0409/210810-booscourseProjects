//
//  CityTableViewCell.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/27.
//

import UIKit

class CityTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var rainfallLabel: UILabel!
    var tmpCity: CityArea?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(_ city: CityArea) {
        cityNameLabel.text = city.cityName
        temperatureLabel.text = city.celsiusAndFahrenheit
        rainfallLabel.text = city.rainStr
        
        rainfallLabel.textColor = city.rainTxtColor
        temperatureLabel.textColor = city.temperatureColor
        
        weatherImg.image = city.weatherImg
        tmpCity = city
    }
}
