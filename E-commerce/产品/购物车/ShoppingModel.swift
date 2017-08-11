//
//  ShoppingModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/1.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct ShoppingModel: Equatable {
    
    var isSelected: Bool = false
    let product_name: String
    let product_id: String
    let goods_number: String
    let sell_price: String
    let market_price: String
    let product_image_url: String
    let product_attr: String

    
    public static func ==(lhs: ShoppingModel, rhs: ShoppingModel) -> Bool {
        return
            lhs.product_name == rhs.product_name &&
                lhs.product_id == rhs.product_id &&
                lhs.product_name == rhs.product_name &&
                lhs.goods_number == rhs.goods_number &&
                lhs.sell_price == rhs.sell_price &&
                lhs.market_price == rhs.market_price &&
                lhs.product_image_url == rhs.product_image_url
    }
    
    static func models(withDic: [String: Any]?) -> [ShoppingModel]? {
        
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
        
        var models = [ShoppingModel]()
        for dic in list {
            
            var dic = dic as! [String : Any]
            dic["isSelected"] = false
            let model = ECMapping.ace(type: ShoppingModel.self, fromDic: dic)
            models.append(model)
        }
        
        return models
    }
}
