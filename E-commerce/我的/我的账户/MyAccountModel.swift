//
//  MyAccountModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/8.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MyAccountModel {
    
    let total_amount: String
    let total_monthly_income: String
    let unsettled_monthly_income: String
    let last_month_settlement: String
    let last_monthly_unsettled: String
    let account_id: String

    static func model(withDic: [String: Any]?) -> MyAccountModel? {
        
        guard let response = withDic else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        let model = ECMapping.ace(type: MyAccountModel.self, fromDic: data)
        return model
    }
    
}
