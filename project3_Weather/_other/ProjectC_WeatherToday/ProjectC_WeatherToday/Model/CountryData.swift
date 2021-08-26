//
//  CountryData.swift
//  ProjectC_WeatherToday
//
//  Created by 김광준 on 2019/12/01.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import Foundation
// MARK: - Country
/// 국가  데이터 -  korean_name 과 asset_name
struct Country: Codable {
    let koreanName: String
    let assetName: String

    enum CodingKeys: String, CodingKey {
        case koreanName = "korean_name"
        case assetName = "asset_name"
    }

}
