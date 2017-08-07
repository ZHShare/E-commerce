//
//  BaseViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseViewController: UIViewController {

  
    func enterLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let logNav = storyboard.instantiateViewController(withIdentifier: "BaseNavigationController") as? BaseNavigationController {
            present(logNav, animated: true, completion: nil)
        }
    }
    
    func hudWithMssage(msg: String) {
        
        
        if Thread.isMainThread {
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud?.mode = .text
            hud?.labelText = msg
            hud?.hide(true, afterDelay: 1.0)
            return
        }
        
        DispatchQueue.main.async {
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud?.mode = .text
            hud?.labelText = msg
            hud?.hide(true, afterDelay: 1.0)
        }
    }
    
}
