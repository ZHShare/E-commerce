//
//  MedicalProductDetailsNearModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/15.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MedicalProductDetailsNearModel {
    
    let cust_name: String
    let cust_no: String
    let locations_lat: String
    let locations_lng: String
    let hosp_principal: String
    let cust_avatar: String
    let cust_address: String
    let cust_mobile: String

    static func models(withDic: [String: Any]?) -> [MedicalProductDetailsNearModel] {
        
        var models = [MedicalProductDetailsNearModel]()
        
        guard let response = withDic else {
            return models
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return models
        }
        
        guard let list = data["list"] as? [Any] else {
            return models
        }
        
        if list.count == 0 { return models }
        
        for dic in list {
            let model = ECMapping.ace(type: MedicalProductDetailsNearModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        
        return models
    }
    
}
