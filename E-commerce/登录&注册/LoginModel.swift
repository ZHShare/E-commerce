//
//  LoginModel.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import MappingAce

fileprivate let userDefaults = UserDefaults.standard

fileprivate enum Key {
    static let saveAndLoad = "Save and Get"
    static let loginFlag = "Login"
    static let phoneNumber = "phoneNumber"
}

enum LoginStatus {
    
    static var isLogined: Bool {
        get {
            return userDefaults.bool(forKey: Key.loginFlag)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.loginFlag)
        }
    }
    
    static func updatePhone(phone: String) {
    
        userDefaults.set(phone, forKey: Key.phoneNumber)
    }
    
    static var phone: String? {
        return userDefaults.string(forKey: Key.phoneNumber)
    }
}

struct LoginModel: Mapping
{
//    let user_mobile: String
//    let user_id: String
//    let user_identifyid: String
//    let user_name: String
//    let user_sex: String
//    let face_image_url: String
//    let user_birthday: String
//    let enterprise_id: String
//    let enterprise_name: String
//    let department_name: String
    
    let access_token: String
    let amount: String
    let assess_num: String
    let cart_num: String
    let collect_num: String
    let confirm_num: String
    let department_name: String
    let enterprise_id: String
    let enterprise_name: String
    let face_image_url: String
    let receipt_num: String
    let review_num: String
    let ship_num: String
    let user_birthday: String
    let user_email: String
    let user_id: String
    let user_identifyid: String
    let user_mobile: String
    let user_name: String
    let user_sex: String
    let voucher_num: String

    static func modelWithDic(dic: [String: Any]?) -> LoginModel? {
        
        if let data = dic?["data"] as? [String: Any] {
            
            return LoginModel.mappingWith(any: data) as? LoginModel
        }
        
        return nil
    }
    
    static func update(key: String, value: String) {
        
        if let dic = userDefaults.dictionary(forKey: Key.saveAndLoad) {
        
            var newDic = dic
            newDic[key] = value
            userDefaults.set(newDic, forKey: Key.saveAndLoad)
        }
    }
}

extension LoginModel {
    
    func save() {

        LoginStatus.isLogined = true
        userDefaults.set(toDictionary(), forKey: Key.saveAndLoad)
    }
    
    static func load() -> LoginModel? {
        
        if let dic = userDefaults.dictionary(forKey: Key.saveAndLoad) {

            return ECMapping.ace(type: LoginModel.self, fromDic: dic)
        }
        return nil
    }
    
    static func remove() {
        
        LoginStatus.isLogined = false
        userDefaults.removeObject(forKey: Key.saveAndLoad)
    }
    
}


