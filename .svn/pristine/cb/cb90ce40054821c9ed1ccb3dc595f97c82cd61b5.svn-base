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
}

struct LoginModel: Mapping
{
    let user_id: String
    let name: String
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


