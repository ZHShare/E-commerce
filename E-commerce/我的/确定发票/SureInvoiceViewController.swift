//
//  DEMOViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/11.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SureInvoiceViewController: BaseViewController {

    @IBOutlet weak var topView: UIView!
    @IBAction func submit() {
        
        print("发票提交")
    }
    
    var tableView: UITableView!
    fileprivate let tableVC = ECStroryBoard.controller(type: SureInvoiceTablViewController.self)

    override func viewDidLoad() {
        super.viewDidLoad()

        configTableView()
        
    }
    
    fileprivate func configTableView() {
        
        self.addChildViewController(tableVC)
        tableView = tableVC.tableView
        topView.addSubview(tableView)
        topView.clipsToBounds = true
        tableView.frame.size.width = topView.frame.size.width
        tableView.frame.size.height = topView.frame.size.height
    }
}
