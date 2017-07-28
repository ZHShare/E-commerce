//
//  BaseTableViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class BaseTableViewController: UITableViewController {

    func enterLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let logNav = storyboard.instantiateViewController(withIdentifier: "BaseNavigationController") as? BaseNavigationController {
            present(logNav, animated: true, completion: nil)
        }
    }
    

}
