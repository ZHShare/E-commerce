//
//  BaseNet.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import EZSwiftExtensions
import SwiftyJSON

let host = "http://192.168.1.41"
let port = "8080"
let objectAddress = "syk-crm-api"
let api = "api"

struct ApiType {
    static let UserInfo = "userinfo"
    static let Pub = "pub"
    static let Home = "home"
}

enum BaseNet {
    
    fileprivate static var headerParams: [String: Any] {
    
        return ["trans_time": Date().toString(format: "hhmmss"),
                "jsessionid": "",
                "network_type": "1",
                "trans_date": Date().toString(format: "yyyyMMdd"),
                "trans_type": "02",
                "phone_system": "1",
                "system_version": "10.0"]
    }
    
    static func fetchDataWith(transCode: String,apiType: String, params: [String: Any], handle: @escaping ([String: Any], Bool, String) -> Void) {
        
        ECHud.show()
        
        let url = "\(host):\(8080)/\(objectAddress)/\(api)/\(apiType)/\(transCode).json"
        
        let newParams = ["head": headerParams, "body": params]
        
        hNet.shareInstance.fetch(url: url).parameters(p: newParams as [String: AnyObject]).go(success: { (response) in
            
            ECHud.hidden()
            if let response = response as? Data {
                
                let obj = JSON(data: response)
                if let dicValue =  obj.dictionaryObject {
                    
                    var isLoadFaild = true
                    if (dicValue["ret_code"] as! String) == "0000" {
                        isLoadFaild = false
                    }
                    
                    handle(dicValue, isLoadFaild, dicValue["ret_msg"] as! String)
                }
            }
            
            
            
        }) { (error) in
            
            ECHud.hidden()
            if let error = error {
                print(error)
                ECHud.outTime()
            }
        }
        
    }
    
    
}
