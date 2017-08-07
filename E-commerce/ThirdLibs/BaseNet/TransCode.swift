//
//  TransCode.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

enum TransCode {
    
    struct UserInfo {
        static let register = "100000"
        static let login = "100010"
        static let personalInfo = "100012"
        static let resetPassword = "100014"
        static let enterprise = "100037"
        static let department = "100038"
        static let feedBack = "100052"
        static let change = "100016"
        static let photo = "100044"
        static let contact = "100046"
    }
    
    struct Pub {
        static let sendCode = "800010"
        static let codeVerify = "800012"
    }
    
}