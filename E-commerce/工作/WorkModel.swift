//
//  WorkModel.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

struct WorkModel {
    
    let title: String
    let imageString: String
    
    static func models() -> [WorkModel] {
        
        var models = [WorkModel]()
        
        for dic in [["title": "公告", "imageString": "work_public_notic"],
                    ["title": "报告", "imageString": "work_report"],
                    ["title": "审批", "imageString": "work_approve"],
                    ["title": "任务", "imageString": "work_task"],
                    ["title": "考勤签到", "imageString": "work_attendance"],
                    ["title": "外勤签到", "imageString": "work_sign_in"]] {
                        let model = ECMapping.ace(type: WorkModel.self, fromDic: dic)
                        models.append(model)
        }
        
        return models
    }
}
