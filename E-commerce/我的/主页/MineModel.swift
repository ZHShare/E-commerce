//
//  MineModel.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MineModel
{
    
    let imageString: String
    let title: String
    
    static func models() -> [MineModel] {
        var models = [MineModel]()
        
        for dic in [["title": "我的账户", "imageString": "mine_account"],
                    ["title": "购物车", "imageString": "mine_shopping_car"],
                    ["title": "我的收藏", "imageString": "mine_collect"],
                    ["title": "我的代金券", "imageString": "mine_allowance"],
                    ["title": "企业通讯录", "imageString": "mine_address_book"],
                    ["title": "帮助", "imageString": "mine_help"],
                    ["title": "设置", "imageString": "mine_setting"]] {
            let model = ECMapping.ace(type: MineModel.self, fromDic: dic)
            models.append(model)
        }
        
        return models
    }
}
