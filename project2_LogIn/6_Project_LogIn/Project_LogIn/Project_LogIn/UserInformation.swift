//
//  UserInformation.swift
//  Project_LogIn
//
//  Created by inooph on 2021/08/19.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    var tellNum: String?
    var birthDay: String?
    var userID: String?
    
    private init() {}
}
