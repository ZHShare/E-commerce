//
//  MedicalProductDetailsPop.swift
//  E-commerce
//
//  Created by YE on 2017/7/28.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MedicalProductDetailsPopModel {
    
    struct Color {
        var title: String
        var isSelected: Bool
        
        static func models() -> [Color]{
            
            return [Color(title: "套餐一2组护理系统", isSelected: false),
                    Color(title: "套餐一3组护理系统", isSelected: false),
                    Color(title: "套餐一4组护理系统", isSelected: false),
                    Color(title: "套餐一6组护理系统", isSelected: false),
                    Color(title: "套餐一9组护理系统", isSelected: false)]
        }
    }
    
    struct Related {
        
        var title: String
        var isSelected: Bool
        
        static func models() -> [Related] {
            
            return [Related(title: "二线主机\n颜色:黑色 白色 灰色\n下单请备注颜色", isSelected: false),
                    Related(title: "三线主机\n颜色:黑色 白色 灰色\n下单请备注颜色", isSelected: false),
                    Related(title: "四线主机\n颜色:黑色 白色 灰色\n下单请备注颜色", isSelected: false),
                    Related(title: "五线主机\n颜色:黑色 白色 灰色\n下单请备注颜色", isSelected: false)]
        }
    }
}
