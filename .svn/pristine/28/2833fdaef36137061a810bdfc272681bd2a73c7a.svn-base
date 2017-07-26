//
//  ECSwiftJSON.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/21.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import SwiftyJSON

public enum ECSwiftJSON {
    
    static func dataToJson(data: Data?) -> [String: Any]? {
        
        if let data = data {
            
            let json = JSON(data: data)
            return json.dictionaryObject
        }
        
        return nil
    }

}
