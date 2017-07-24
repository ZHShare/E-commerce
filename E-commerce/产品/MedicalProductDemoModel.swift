
//
//  MedicalProductDemoModel.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct ADModel {
    
    let title: String
    
    static func fecthDatas() -> [ADModel] {
        
        var models = [ADModel]()
        
        for title in ["系统新上线，全部产品5折",
                      "系统套餐,5.5折起",
                      "半个月内订单付款,4折起"] {
                        
                        let model = ADModel(title: title)
                        models.append(model)
        }
        
        return models
    }
}

struct ButtonModel {
    
    let title: String
    let imageString: String
    
    static func fetchDatas() -> [ButtonModel] {
        
        var models = [ButtonModel]()
        
        for dic in [["title": "传呼类", "imageString": "product_call1"],
                    ["title": "护理系统", "imageString": "product_nurse"],
                    ["title": "传呼类", "imageString": "product_call"],
                    ["title": "消毒机", "imageString": "product_disinfect"],
                    ["title": "输液报警器", "imageString": "product_infusion"],
                    ["title": "制氧机", "imageString": "product_make_oxygen"],
                    ["title": "工程设计", "imageString": "product_engineering"],
                    ["title": "工程产品", "imageString": "pruduct_device"]] {
                        
                        
                        let model = ECMapping.ace(type: ButtonModel.self, fromDic: dic)
                        models.append(model)
        }
        
        return models
    }
}
