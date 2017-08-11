//
//  BaseTableViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import MBProgressHUD

class BaseTableViewController: UITableViewController {

    func enterLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let logNav = storyboard.instantiateViewController(withIdentifier: "BaseNavigationController") as? BaseNavigationController {
            present(logNav, animated: true, completion: nil)
        }
    }
    
    func hudWithMssage(msg: String) {
        
        DispatchQueue.main.async {
            
            let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
            hud?.mode = .text
            hud?.labelText = msg
            hud?.hide(true, afterDelay: 1.0)
        }
    }
    
    func hudForWindowsWithMessage(msg: String) {
        
        DispatchQueue.main.async {
            
            let hud = MBProgressHUD.showAdded(to: UIApplication.shared.keyWindow!, animated: true)
            hud?.mode = .text
            hud?.labelText = msg
            hud?.hide(true, afterDelay: 1.0)
        }
    }
    
}
