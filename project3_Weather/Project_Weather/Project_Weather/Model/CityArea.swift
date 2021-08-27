//
//  CityArea.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/27.
//

import Foundation
import UIKit

struct CityArea: Codable {
    let cityName: String
    let state: Int
    let celsius: Double
    let rainfall: Int
    
    //화씨= (섭씨x1.8) + 32
    var celsiusAndFahrenheit: String {
        let fahrenheit: Double = (celsius * 1.8) + 32
        let fahStr: String = String(format: "%.1f", fahrenheit)
        return "섭씨 \(celsius)도 / 화씨 \(fahStr)도"
    }
    
    var weatherImg: UIImage? {
        let tmpWeather: String
        
        switch state {
        case 10:
            tmpWeather = "sunny"
        case 11:
            tmpWeather = "cloudy"
        case 12:
            tmpWeather = "rainy"
        case 13:
            tmpWeather = "snowy"
        default:
            tmpWeather = ""
            print("이미지가 존재하지 않습니다.")
        }
        return UIImage(named: tmpWeather)
    }
    
    var rainStr: String {
        "강수확률 \(rainfall)%"
    }
    
    var weatherStr: String {
        switch state {
        case 10:
            return "맑음"
        case 11:
            return "흐림"
        case 12:
            return "비"
        case 13:
            return "눈"
        default:
            return "-"
        }
    }
    
    var rainTxtColor: UIColor {
        var color: UIColor
        if rainfall >= 60 {
            color = .orange
        } else {
            color = .label
        }
        return color
    }
    
    var temperatureColor: UIColor {
        var color: UIColor
        if celsius < 10 {
            color = .blue
        } else if celsius > 20 {
            color = .red
        } else {
            color = .label
        }
        return color
    }
    
    enum CodingKeys: String, CodingKey {
        case cityName = "city_name"
        case state, celsius
        case rainfall = "rainfall_probability"
    }
}
