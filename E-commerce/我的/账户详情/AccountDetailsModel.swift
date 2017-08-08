//
//  AccountDetailsModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct AccountDetailsModel {
    
    let product_id: String
    let product_name: String
    let product_image_url: String
    let product_num: String
    let product_price: String
    let order_total_amount: String
    let product_attr: String
    let commission_amount: String
    let trans_time: String
    let in_out_type: String

    
    
    static func models(withDic: [String: Any]?) -> (String,[AccountDetailsModel])? {
        
        guard let response = withDic else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        var total = ""
        if let t = data["total_monthly_income"] as? String {
            total = t
        }
        else if let t = data["total_monthly_income"] as? NSNumber {
            total = t.stringValue
        }
        
        guard let list = data["list"] as? [Any] else {
            return nil
        }
        
        if list.count == 0 { return nil }
        
        var models = [AccountDetailsModel]()
        for dic in list {
            
            let model = ECMapping.ace(type: AccountDetailsModel.self, fromDic: dic as! [String : Any])
            models.append(model)
        }
        
        return (total,models)
        
    }

}
