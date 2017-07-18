//
//  HNet.swift
//  S-HttpRequest
//
//  Created by 王雄皓 on 16/5/19.
//  Copyright © 2016年 王雄皓. All rights reserved.
//

import Foundation

class HNet: NSObject {

    func buildParams(parameters: [String: AnyObject]) -> String {
        var components: [(String, String)] = []
        for key in Array(parameters.keys).sorted() {
            let value: AnyObject! = parameters[key]
            components += self.queryComponents(key: key, value)
        }
        
        return (components.map{"\($0)=\($1)"} as [String]).joined(separator: "&")
    }
    
    
    private func queryComponents(key: String, _ value: AnyObject) -> [(String, String)] {
        var components: [(String, String)] = []
        if let dictionary = value as? [String: AnyObject] {
            for (nestedKey, value) in dictionary {
                components += queryComponents(key: "\(key)[\(nestedKey)]", value)
            }
        } else if let array = value as? [AnyObject] {
            for value in array {
                components += queryComponents(key: "\(key)", value)
            }
        } else {
            components.append(contentsOf: [(escape(string: key), escape(string: "\(value)"))])
        }
        
        return components
    }
    
    private func escape(string: String) -> String {
        let legalURLCharactersToBeEscaped: CFString = ":&=;+!@#$()',*" as CFString
        return CFURLCreateStringByAddingPercentEscapes(nil, string as CFString!, nil, legalURLCharactersToBeEscaped, CFStringBuiltInEncodings.UTF8.rawValue) as String
    }
    
}

extension HNet {
    
    class func request( method : String = "GET",url : String ,form : Dictionary<String,AnyObject> = [:],success : @escaping (_ data : NSData?)->Void,fail:@escaping (_ error : NSError?)->Void){
        
        var innerUrl = url
        
        if method == "GET"{
            innerUrl += "?" + HNet().buildParams(parameters: form)
        }
        
        let req = NSMutableURLRequest(url: NSURL(string: innerUrl)! as URL)
        
        req.httpMethod = method
        
        if method == "POST" {
           
            req.addValue("application/json;charset=utf-8", forHTTPHeaderField: "Content-Type")
            
            print("POST PARAMS \(form)")
            
            let options = JSONSerialization.WritingOptions()
            let data = try? JSONSerialization.data(withJSONObject: form, options: options)
            
            if req.value(forHTTPHeaderField: "Content-Type") == nil {
                req.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
            req.httpBody = data
        }
        
        let session = URLSession.shared
        
        print(req.description)
        
        let task = session.dataTask(with: req as URLRequest) { (data, response, error) -> Void in
            if error != nil{
                fail(error as NSError?)
                if let res = response {
                    print(res)
                }
            }else{
                if (response as! HTTPURLResponse).statusCode  == 200{
                    success(data as NSData?)
                }else{
                    fail(error as NSError?)
                    if let res = response {
                        print(res)
                    }
                    
                }
            }
            
        }
        
        task.resume()
    }
    
}
