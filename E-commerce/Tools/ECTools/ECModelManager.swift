//
//  ECModelManager.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/21.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

public enum ECModelManager {
    
    static func modelWithType<T>(type: T.Type = T.self, data resultData: NSData?) -> T? {
        
        if let data = resultData as Data? {
            
            if let data = ECSwiftJSON.dataToJson(data: data) {
                
                let result = ECMapping.ace(type: type, fromDic: data)
                return result
            }
            
        }
      
        return nil
    }
}
