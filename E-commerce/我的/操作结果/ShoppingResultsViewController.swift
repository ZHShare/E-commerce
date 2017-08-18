//
//  ShoppingResultsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/18.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ShoppingResultsViewController: BaseViewController
{

    var order_id: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }

    fileprivate func configNavigationBar() {
        
        navigationItem.title = "操作结果"

    }
    
    
    
    @IBAction func details() {
        
        print("查看订单详情\(order_id ?? "")")
        let orddingDetailsViewController = ECStroryBoard.controller(type: OrderDetailsViewController.self)
        navigationController?.ecPushViewController(orddingDetailsViewController)
    }
    
}
