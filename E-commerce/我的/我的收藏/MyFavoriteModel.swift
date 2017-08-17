//
//  MyFavoriteModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MyFavoriteModel {
    
    let product_id: String
    let product_name: String
    let cat_id: String
    let product_image_url: String
    let sell_price: String
    let market_price: String
    
    static func models(withDic: [String: Any]?) -> [MyFavoriteModel]? {
       
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
        
        var models = [MyFavoriteModel]()
        for dic in list {
            
            let model = ECMapping.ace(type: MyFavoriteModel.self, fromDic: dic as! [String : Any])
            models.append(model)
        }
        
        return models
    }
}

