//
//  WeatherData.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/04.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import Foundation
import UIKit
// MARK: - WeatherData
/// 날씨 데이터  코더블

struct WeatherData: Codable {

    let cityName: String
    let state: Int
    let celsius: Float
    let rainfallProbability: Int

    enum CodingKeys: String, CodingKey {
        case state, celsius
        case cityName = "city_name"
        case rainfallProbability = "rainfall_probability"
    }
    
    var fahrenheit: Float {
        let input = (self.celsius * 1.8) + 32
        let output = floor(input * 10) / 10
        return output
    }
    
    var percentageOfrainfall: String {
        return ("강수확률 \(self.rainfallProbability)%")
    }
    
    var celsiusAndFahrenheit: String {
        return ("섭씨 \(self.celsius)도 / 화씨 \(self.fahrenheit)도")
    }
    
    var weatherStateNumToKr: String {
        switch state {
        case 10:
            return "해"
        case 11:
            return "구름"
        case 12:
            return "비"
        case 13:
            return "눈"
        default:
            return "에러"
        }
    }
//    enum WeatherState: Int {
//        case sun = 10
//        case cloudy = 11
//        case rainy = 12
//        case snow = 13
//        
//        var name: String {
//            switch self {
//            case .sun: return "해"
//            case .cloudy: return "구름"
//            case .rainy: return "비"
//            case .snow: return "눈"
//            }
//        }
//    }
}




