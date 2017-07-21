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
        
        enterLogin()
        
        if let user = LoginModel.getModel() {
            
           print("\(String(describing: user))\n\(String(describing: user.name))\n\(String(describing: user.user_id))")
        }
        
    }

    @IBAction func exit() {
        
        LoginModel.remove()
    }
}
