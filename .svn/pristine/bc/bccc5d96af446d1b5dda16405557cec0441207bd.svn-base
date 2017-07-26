//
//  MessageModel.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct MessageModel {
    
    let imageString: String
    let title: String
    let subTitle: String
    
    static func models() -> [MessageModel] {
        
        var models = [MessageModel]()
        
        for dic in [["imageString": "message_work", "title": "工作", "subTitle": "亲，您目前还没有进行中的工作"],
                    ["imageString": "message_agency", "title": "代办", "subTitle": "亲，您目前还有10条代办工作，加油哦！"],
                    ["imageString": "message_recive", "title": "回复", "subTitle": "亲，您目前还有12条消息还没有回复。"],
                    ["imageString": "message_tapz", "title": "点赞", "subTitle": "亲，您目前点赞消息比较多，说明阅读还不错哦！"],
                    ["imageString": "message_public_notic", "title": "公告", "subTitle": "公告信息目前有5条，请尽快查阅"]] {
            
                        let model = ECMapping.ace(type: MessageModel.self, fromDic: dic)
                        models.append(model)
        }
        
        return models
    }
    
}
