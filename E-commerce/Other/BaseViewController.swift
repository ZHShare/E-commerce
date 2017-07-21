//
//  BaseViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

  
    func enterLogin() {
        
        if isLogin() { return }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let logNav = storyboard.instantiateViewController(withIdentifier: "BaseNavigationController") as? BaseNavigationController {
            present(logNav, animated: true, completion: nil)
        }
    }

    fileprivate func isLogin() -> Bool {
        
        return LoginModel.status()
    }
    
}
