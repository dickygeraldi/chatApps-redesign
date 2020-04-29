//
//  AuthModels.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 28/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import Foundation

struct UserAuth {
    var phoneNumber: String
    var token: String
    var username: String
    
    init(phoneNumber: String, token: String, username: String) {
        self.phoneNumber = phoneNumber
        self.token = token
        self.username = username
    }
}

struct ResponseAuth {
    var code: String
    var message: String
    var token: String
    
    init(code: String, token: String, message: String) {
        self.code = code
        self.message = message
        self.token = token
    }
}

struct RegisterUsers: Codable {
    var code: String
    var status: String
    var message: String
    var data: DataResponseRegister
}

struct DataResponseRegister: Codable {
    var username: String
}

struct LoginUsers: Codable {
    var code: String
    var status: String
    var message: String
    var data: DataResponseLogin
}

struct DataResponseLogin: Codable {
    var token: String
    var isActive: Bool
    var username: String
    var loggedTime: String
}
