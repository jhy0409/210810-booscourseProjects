//
//  FlagData.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/11/30.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import Foundation
import UIKit

// MARK: - FlagImageData
/// 국가별 국기 이미지 데이터

struct FlagImageData {
    
    let germanyFlag: UIImage = {
        var germany: UIImage = UIImage()
        if let germanyFlagImg = UIImage.init(named: "flag_de") {
            germany = germanyFlagImg
            print("Success: Get Germany Flag Image")
        } else {
            fatalError("Can't get Germany Flag Image")
//            print("Error: Germany Flag Image not found")
        }
        return germany
    }()

    let franceFlag: UIImage = {
        var france: UIImage = UIImage()
        if let franceFlagImg = UIImage.init(named: "flag_fr") {
            france = franceFlagImg
            print("Success: Get France Flag Image")
        } else {
            fatalError("Can't get France Flag Image")
//            print("Error: France Flag Image not found")
        }
        return france
    }()

    let italyFlag: UIImage = {
        var italy: UIImage = UIImage()
        if let italyFlagImg = UIImage.init(named: "flag_it") {
            italy = italyFlagImg
            print("Success: Get Italy Flag Image")
        } else {
            fatalError("Can't get Italy Flag Image")
//            print("Error: Italy Flag Image not found")
        }
        return italy
    }()

    let japanFlag: UIImage = {
        var japan: UIImage = UIImage()
        if let japanFlagImg = UIImage.init(named: "flag_jp") {
            japan = japanFlagImg
            print("Success: Get Japan Flag Image")
        } else {
            fatalError("Can't get Japan Flag Image")
//            print("Error: Japan Flag Image not found")
        }
        return japan
    }()

    let koreaFlag: UIImage = {
        var korea: UIImage = UIImage()
        if let koreaFlagImg = UIImage.init(named: "flag_kr") {
            korea = koreaFlagImg
            print("Success: Get Korea Flag Image")
        } else {
            fatalError("Can't get Korea Flag Image")
//            print("Error: Korea Flag Image not found")
        }
        return korea
    }()

    let usaFlag: UIImage = {
        var usa: UIImage = UIImage()
        if let usaFlagImg = UIImage.init(named: "flag_us") {
            usa = usaFlagImg
            print("Success: Get USA Flag Image")
        } else {
            fatalError("Can't get USA Flag Image")
//            print("Error: USA Flag Image not found")
        }
        return usa
    }()
    
}



