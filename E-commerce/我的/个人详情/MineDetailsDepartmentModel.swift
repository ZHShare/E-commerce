//
//  MineDetailsDepartmentModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MineDetailsDepartmentModel {
    
    let department_name: String
    let department_id: String
    let superior_department_id: String
    
    static func models<T>(type: T.Type = T.self, fromDic dic: [String : Any]) -> NSMutableArray {
        
        let lists = NSMutableArray()
        
        guard let data = dic["data"] as? [String: Any] else {
            return lists
        }
        
        guard let list = data["list"] as? [Any] else {
            return lists
        }
        
        if list.count == 0 {
            return lists
        }
        
        for dic in list {
            
            let model = ECMapping.ace(type: MineDetailsDepartmentModel.self, fromDic: dic as! [String : Any])
            lists.add(model)
        }
        
        return lists
    }
}
