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
        static let myShoppingCar = "100018"
        static let delShoppingCar = "100024"
        static let enterprise = "100037"
        static let department = "100038"
        static let feedBack = "100052"
        static let change = "100016"
        static let photo = "100044"
        static let contact = "100046"
        static let myAccountDetails = "100035"
        static let myAccount = "100036"
        static let myFavorite = "100028"
        static let addFav = "100026"
        static let removeFav = "100027"
        
        static let addShoppingCar = "100020"
    }
    
    struct Pub {
        static let sendCode = "800010"
        static let codeVerify = "800012"
    }
    
    struct Home {
        static let mainPage = "200010"
        static let firstClass = "200012"
        static let secondClass = "200013"
        static let productDetails = "200014"
        static let nearCustomer = "200021"
        static let evaluation = "200016"
        static let type =  "200015"
        static let sureShopping = "200022"
        static let publicNotice = "200030"
    }
    
    struct CRM {
        
        static let customerNew = "300010"
        static let customerList = "300012"
        static let contactNew = "300014"
        static let contactList = "300016"
    }
}
