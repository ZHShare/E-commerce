//
//  ProductViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductViewController: BaseViewController
{

    
    @IBAction func login(_ sender: UIButton) {
        
        if LoginStatus.isLogined {
            
            if let user = LoginModel.load() {
                
                print("\n\(String(describing: user))\n\(String(describing: user.name))\n\(String(describing: user.user_id))")
            }
            return
        }

        enterLogin()
    }

    @IBAction func exit() {
        
        LoginModel.remove()
    }
}
