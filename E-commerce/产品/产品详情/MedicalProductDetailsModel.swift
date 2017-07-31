//
//  MedicalProductDetailsModel.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MedicalProductDetailsModel {
    
    struct SectionOne {
        var title: String
        
        static func models() -> [SectionOne] {
            
            return [SectionOne(title: "选择型号数量"), SectionOne(title: "产品参数")]
        }
    }
    
    struct SectionTwo {
        
        let name: String
        let content: String
        let date: String
        
        static func models() -> [SectionTwo] {
            
            return [SectionTwo.init(name: "汽车销售", content: "可以理解，本次快递小哥送货时间和速度的方面都还可以，送货非常快，只用了3天就 送来了。8月20号至8月23号下单", date: "2017-08-25")]
        }
    }
    
}
