//
//  HomeNet.swift
//  E-commerce
//
//  Created by YE on 2017/8/9.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

enum HomeNet {
    
    static func fetchDataWith(transCode: String, params: [String: Any], handle: @escaping ([String: Any], Bool, String) -> Void) {
        
        BaseNet.fetchDataWith(transCode: transCode, apiType: ApiType.Home, params: params, handle: handle)
    }
    
}
