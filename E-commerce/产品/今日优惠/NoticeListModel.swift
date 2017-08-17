//
//  NoticeListModel.swift
//  E-commerce
//
//  Created by YE on 2017/8/16.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct NoticeListModel {
   
    let notice_id: String
    let notice_title: String
    let notice_img: String
    let notice_type: String
    let admin_name: String
    let add_time: String
    
    static func models(withResponse: [String: Any]?) -> [NoticeListModel]? {
        
        guard let response = withResponse else {
            return nil
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return nil
        }
        
        guard let list = data["list"] as? [Any] else {
            return nil
        }
        
        if list.count == 0 { return nil }
        
        var models = [NoticeListModel]()
        for dic in list {
            
            let model = ECMapping.ace(type: NoticeListModel.self, fromDic: dic as! [String: Any])
            models.append(model)
        }
        
        return models
    }
    
    
}
