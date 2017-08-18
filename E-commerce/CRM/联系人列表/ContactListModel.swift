//
//  ContactListModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/17.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct ContactListModel {
    
    let contact_id: String
    let name: String
    let mobile: String
    let address: String
    let phone: String
    let relationship: String
    let default_flag: String
    let cust_address: String
    let cust_no: String

    static func models(withResponse: [String: Any]?) -> [ContactListModel]? {
        
        guard let response = withResponse else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        guard let list = data["list"] as? [Any] else {
            return nil
        }
        
        if list.count == 0 { return nil }
        
        var models = [ContactListModel]()
        for dic in list {
            let model = ECMapping.ace(type: ContactListModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        return models
    }
}
