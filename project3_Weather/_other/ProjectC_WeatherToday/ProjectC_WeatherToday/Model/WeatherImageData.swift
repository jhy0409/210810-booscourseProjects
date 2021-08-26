//
//  WeatherData.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/01.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import Foundation
import UIKit
// MARK: - WeatherImageData
/// 날씨별 이미지 데이터
struct WeatherImageData {
   
    let cloudy: UIImage = {
        let state: Int = 11
        let krNameCloudy: String = "구름"
        var cloudy: UIImage = UIImage()
        if let cloudyImg = UIImage.init(named: "cloudy") {
            cloudy = cloudyImg
            print("Success: Get cloudy Image")
        } else {
            print("Error: not found cloudy image")
        }
        return cloudy
    }()

    let rainy: UIImage = {
        let state: Int = 12
        let krNameRainy: String = "비"
        var rainy: UIImage = UIImage()
        if let rainyImg = UIImage.init(named: "rainy") {
            rainy = rainyImg
            print("Success: Get rainy Image")
        } else {
            print("Error: not found rainy image")
        }
        return rainy
    }()

    let snowy: UIImage = {
        let state: Int = 13
        let krNameSnowy: String = "눈"
        var snowy: UIImage = UIImage()
        if let snowyImg = UIImage.init(named: "snowy") {
            snowy = snowyImg
            print("Success: Get snowy Image")
        } else {
            print("Error: not found snowy image")
        }
        return snowy
    }()

    let sunny: UIImage = {
        let state: Int = 10
        let krNameSunny: String = "해"
        var sunny: UIImage = UIImage()
        if let sunnyImg = UIImage.init(named: "sunny") {
            sunny = sunnyImg
            print("Success: Get sunny Image")
        } else {
            print("Error: not found sunny image")
        }
        return sunny
    }()
    
}

