//
//  FirstClassifyModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/10.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct FirstClassifyModel {
    
    let cat_id: String
    let cat_name: String
    
    static func models(withDic: [String: Any]?) -> [FirstClassifyModel]? {
        
        guard let response = withDic else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        guard let list = data["list"] as? [Any] else {
            return nil
        }
        
        if list.count == 0 { return nil }
        
        var models = [FirstClassifyModel]()
        for dic in list {
            
            let model = ECMapping.ace(type: FirstClassifyModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        
        return models
    }
}
class SecondClassifyModel: NSObject {
    
    var cat_id: String = ""
    var cat_name: String = ""
    var subs: [SecondClassifySubModel]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if let value = value as? NSNumber {
            return super.setValue(value.stringValue, forKey: key)
        }
        super.setValue(value, forKey: key)
    }
    
    static func models(withDic: [String: Any]?) -> [SecondClassifyModel]? {
        
        guard let response = withDic else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        guard let list = data["list"] as? [Any] else {
            return nil
        }
        
        if list.count == 0 { return nil }
        
        var models = [SecondClassifyModel]()
        for dic in list {
            
            let model = SecondClassifyModel()
            model.setValuesForKeys(dic as! [String : Any])
            models.append(model)
        }
        return models
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        if key == "sub" {
            if let value = value as? [Any] {
                subs = SecondClassifySubModel.models(withArr: value)
            }
        }
    }
}
struct SecondClassifySubModel {
    
    let sub_cat_id: String
    let sub_cat_name: String
    let cat_image_url: String

    static func models(withArr: [Any]) -> [SecondClassifySubModel] {
        
        var models = [SecondClassifySubModel]()
        
        for dic in withArr {
            let model = ECMapping.ace(type: SecondClassifySubModel.self, fromDic: (dic as? [String: Any])!)
            models.append(model)
        }
        return models
    }
}
