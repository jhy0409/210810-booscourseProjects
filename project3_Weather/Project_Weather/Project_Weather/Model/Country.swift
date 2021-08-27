//
//  Country.swift
//  Project_Weather
//
//  Created by inooph on 2021/08/26.
//

import Foundation
import UIKit
//{"korean_name":"한국","asset_name":"kr"}

struct Country: Codable {
    //let korean_name: String
    let contName: String
    //let asset_name: String
    let shortName: String
    
    var image: UIImage? {
        return UIImage(named: "flag_\(shortName).jpg")
    }
    
    enum CodingKeys: String, CodingKey {
        case contName = "korean_name"
        case shortName = "asset_name"
    }
}
