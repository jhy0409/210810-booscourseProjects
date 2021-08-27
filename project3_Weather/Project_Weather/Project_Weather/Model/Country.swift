//
//  Country.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/26.
//

import Foundation
import UIKit

struct Country: Codable {
    let contName: String // 나라 이름
    let shortName: String // 나라이름 영어 약자 - ko
    
    // 국기
    var image: UIImage? {
        return UIImage(named: "flag_\(shortName).jpg")
    }
    
    enum CodingKeys: String, CodingKey {
        case contName = "korean_name"
        case shortName = "asset_name"
    }
}
