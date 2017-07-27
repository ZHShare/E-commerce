
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

struct ListModel {
    
    let title: String
    let imageString: String
    let subTitle: String
    let isDisCount: Bool
    let isP: Bool
    
    static func fetchDatas() -> [ListModel] {
        
        var models = [ListModel]()
        
        for dic in [["title": "天天向上", "imageString": "1", "subTitle": "输液报警器", "isDisCount": true, "isP": false],
                    ["title": "好好学习", "imageString": "2", "subTitle": "输液报警器", "isDisCount": false, "isP": true],
                    ["title": "看不见", "imageString": "2", "subTitle": "系统新上线，全部产品5折", "isDisCount": false, "isP": false],
                    ["title": "输液", "imageString": "product_call1", "subTitle": "系统新上线，全部产品5折", "isDisCount": false, "isP": false],
                    ["title": "制氧", "imageString": "Share_QzoneIcon_70x70_", "subTitle": "输液报警器", "isDisCount": false, "isP": false],
                    ["title": "AA工八号设计", "imageString": "tabbar_work_selcted", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "尝试消毒", "imageString": "product_call1", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "产品传呼", "imageString": "product_bargain_offer", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "热门产品", "imageString": "pruduct_device", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "护理系统", "imageString": "product_make_oxygen", "subTitle": "系统新上线，全部产品5折", "isDisCount": false, "isP": false],
                    ["title": "天天向上", "imageString": "product_call1", "subTitle": "输液报警器", "isDisCount": true, "isP": false],
                    ["title": "好好学习", "imageString": "gouwuche", "subTitle": "输液报警器", "isDisCount": false, "isP": true],
                    ["title": "看不见", "imageString": "椭圆-2", "subTitle": "系统新上线，全部产品5折", "isDisCount": false, "isP": false],
                    ["title": "输液", "imageString": "product_bargain_offer", "subTitle": "系统新上线，全部产品5折", "isDisCount": false, "isP": false],
                    ["title": "制氧", "imageString": "Share_QzoneIcon_70x70_", "subTitle": "输液报警器", "isDisCount": false, "isP": false],
                    ["title": "AA工八号设计", "imageString": "tabbar_work_selcted", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "尝试消毒", "imageString": "product_call1", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "产品传呼", "imageString": "product_bargain_offer", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "热门产品", "imageString": "pruduct_device", "subTitle": "半个月内订单付款,4折起", "isDisCount": false, "isP": false],
                    ["title": "护理系统", "imageString": "product_make_oxygen", "subTitle": "系统新上线，全部产品5折", "isDisCount": false, "isP": false]] {
            
                        let model = ECMapping.ace(type: ListModel.self, fromDic: dic)
                        models.append(model)
        }
        
        return models
    }
}
