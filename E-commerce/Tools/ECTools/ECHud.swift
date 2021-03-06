//
//  ECHud.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation
import MBProgressHUD

fileprivate var hud : MBProgressHUD?

enum ECHud {
    
    
    static func show() {
        
        DispatchQueue.main.async {
            
            hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            hud?.hide(true, afterDelay: TimeInterval(10))
        }
       
    }
    
    static func hidden() {
        
        DispatchQueue.main.async {
            hud?.hide(true)
        }
    }
    
    static func outTime() {
       
        DispatchQueue.main.async {
            
            let shud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            shud?.mode = .text
            shud?.labelText = "网络异常，请检查网络后重试"
            shud?.hide(true, afterDelay: 1.0)
        }
    }
}

