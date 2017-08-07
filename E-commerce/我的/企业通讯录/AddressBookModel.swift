//
//  AddressBookModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/7.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

class AddressBookModel: NSObject {
    
    var name: String = ""
    var nickname: String = ""
    var mobile: String = ""
    var enterprise_name: String = ""
    var department_name: String = ""
    var head_portrait: String = ""
    var sex: String = ""
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print("\(key) ==== NONE ===== ")
    }
    
    static func models(dic: [String: Any]?) -> [AddressBookModel]? {
        
        guard let dic = dic else {
            return nil
        }
        
        guard let data = dic["data"] as? [String: Any] else {
            return nil
        }
        
        guard let list = data["list"] as? [Any] else {
            return nil
        }
        
        if list.count == 0 { return nil }
        
        let models = NSMutableArray()
        
        for dic in list {
            
            let model = AddressBookModel()
            model.setValuesForKeys(dic as! [String : Any])
            models.add(model)
        }
        
        
        return models as? [AddressBookModel]
    }
    
}
