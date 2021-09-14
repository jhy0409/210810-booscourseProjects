//
//  UserInformation.swift
//  Project_LogIn
//
//  Created by inooph on 2021/08/19.
//

import Foundation

class UserInformation {
    static let shared: UserInformation = UserInformation()
    
    var userID: String?
    var birthDay: String?
    var phoneNumber: String?
    
    private init() {}
}
