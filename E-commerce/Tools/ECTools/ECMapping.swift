//
//  ECMapping.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/21.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import MappingAce

public enum ECMapping {
    
    static func ace<T>(type: T.Type = T.self, fromDic dic: [String : Any]) -> T{

        return MappingAny(type: type, fromDic: dic)
    }
    
}
