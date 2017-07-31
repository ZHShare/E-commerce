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
        
        hud?.hide(true)
    }
}

