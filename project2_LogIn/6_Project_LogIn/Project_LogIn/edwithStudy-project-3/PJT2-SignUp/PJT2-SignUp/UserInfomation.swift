//
//  UserInfomation.swift
//  PJT2-SignUp
//
//  Created by 김광준 on 2019/11/22.
//  Copyright © 2019 VincentGeranium. All rights reserved.
//

import Foundation

class UserInfomation {
    static let shared: UserInfomation = UserInfomation()
    
    var id: String?
    var password: String?
    var phoneNumber: String?
    var dateOfBirth: String?
}
