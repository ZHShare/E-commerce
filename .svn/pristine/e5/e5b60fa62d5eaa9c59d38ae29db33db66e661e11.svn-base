//
//  HHttp.swift
//  S-HttpRequest
//
//  Created by 王雄皓 on 16/5/19.
//  Copyright © 2016年 王雄皓. All rights reserved.
//

import Foundation

enum RequestMethod {
    case Post
    case Get
}

typealias hNet  = HHttp


class HHttp {
    
    var method: RequestMethod
    let hostName = ""
    var curUrl   = ""
    var parameters: [String: AnyObject] = [:]
    
    static let shareInstance = HHttp(m: .Post)
    
    init(m: RequestMethod){
        
        method = m
    }
    
    func fetch(url : String) -> HHttp{

        curUrl = url
        return self
    }
    
    func parameters(p: [String: AnyObject]) -> HHttp {
        
        _ = p.reduce("", { (str, p) -> String in
            
            parameters[p.0] = p.1
            return ""
        })
        return self
    }
    
    func go(success: @escaping (AnyObject) -> Void, failure: @escaping (NSError?)-> Void){
        
        var smethod = ""
        
        if method == .Get {
            
            smethod = "GET"
        }else {
            smethod = "POST"
        }
        
        HNet.request(method: smethod, url: curUrl, form: parameters, success: { (data) -> Void in
          
            print("request successed in \(self.curUrl)")
            success(data!)
        }) { (error) -> Void in
            print("request failed in \(self.curUrl)")
            failure(error)
        }
    }
   
}

