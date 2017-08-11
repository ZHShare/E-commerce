//
//  ProductEvalutaionModel.swift
//  E-commerce
//
//  Created by YE on 2017/7/31.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct ProductEvalutaionModel {
    
    let user_name: String
    let user_id: String
    let face_image_url: String
    let content: String
    let add_time: String
    let comment_rank: String

    static func models(withResponse: [String: Any]?) -> [ProductEvalutaionModel] {
        
      
        var models = [ProductEvalutaionModel]()
        
        guard let response = withResponse else {
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
            let model = ECMapping.ace(type: ProductEvalutaionModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        return models
    }
}
