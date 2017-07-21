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

struct LoginModel: Mapping
{
    let user_id: String
    let name: String
    
    fileprivate enum Key {
        static let saveAndGet = "Save and Get"
        static let loginFlag = "Login"
    }
}
extension LoginModel {
    
    func save() {
        
        let dic = ["user_id": user_id,
                   "name": name]
        
        userDefaults.set(true, forKey: Key.loginFlag)
        userDefaults.set(dic, forKey: Key.saveAndGet)
    }
    
    static func getModel() -> LoginModel? {
        
        if let dic = userDefaults.dictionary(forKey: Key.saveAndGet) {

            return ECMapping.ace(type: LoginModel.self, fromDic: dic)
        }
        return nil
    }
    
    static func remove() {
        
        userDefaults.set(false, forKey: Key.loginFlag)
        userDefaults.removeObject(forKey: Key.saveAndGet)
    }
    
    static func status() -> Bool {
        
        return userDefaults.bool(forKey: Key.loginFlag)
    }
}


