//
//  ProductViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController
{

    
    @IBAction func login(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let logNav = storyboard.instantiateViewController(withIdentifier: "LogNavViewController") as? LogNavViewController {
            present(logNav, animated: true, completion: nil)
        }
    }

}
