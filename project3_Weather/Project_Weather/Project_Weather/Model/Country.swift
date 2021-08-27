//
//  Country.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/26.
//

import Foundation
import UIKit

struct Country: Codable {
    let contName: String
    let shortName: String
    var image: UIImage? {
        return UIImage(named: "flag_\(shortName).jpg")
    }
    
    enum CodingKeys: String, CodingKey {
        case contName = "korean_name"
        case shortName = "asset_name"
    }
}
