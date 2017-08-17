//
//  MyCustomerModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation


struct MyCustomerModel {
    
    let cust_name: String
    let cust_type: String
    let hosp_principal: String
    let cust_avatar: String
    let cust_address: String
    let cust_no: String
    
    static func models(withDic: [String: Any]?) -> [MyCustomerModel]? {
        
        guard let response = withDic else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        guard let list = data["list"] as? [Any] else {
            return  nil
        }
        
        if list.count == 0 { return nil }
        
        var models = [MyCustomerModel]()
        for dic in list {
            
        
            let model = ECMapping.ace(type: MyCustomerModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        
        return models
    }
    
}
