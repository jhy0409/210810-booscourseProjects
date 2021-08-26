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
    let korean_name: String
    let asset_name: String
    
    var image: UIImage? {
        return UIImage(named: "flag_\(asset_name).jpg")
    }
}
