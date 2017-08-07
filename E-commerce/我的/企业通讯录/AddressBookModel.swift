//
//  AddressBookModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/7.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct AddressBookModel {
    let sex: String
    let head_portrait: String
    let department_name: String
    let enterprise_name: String
    let mobile: String
    let name: String
    
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
            
            let model = ECMapping.ace(type: AddressBookModel.self, fromDic: dic as! [String : Any])
            models.add(model)
        }
        
        
        return models as? [AddressBookModel]
    }
    
    static var response: [String: Any]? {
        return ["data":
            ["list": [
                ["sex": "1","head_portrait": "", "department_name": "电子产品研发一部", "enterprise_name": "一特","mobile": "13755002245", "name": "王雄皓"],
                ["sex": "0","head_portrait": "", "department_name": "电子产品研发二部", "enterprise_name": "湖南一尚","mobile": "13755002244", "name": "大锤子"],
                ["sex": "1","head_portrait": "", "department_name": "电子产品研发二部", "enterprise_name": "湖南一尚","mobile": "13755002244", "name": "王大爷"]
                ]
            ]
        ]
    }
    
}
