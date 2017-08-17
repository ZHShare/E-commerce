//
//  CRMViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class CRMViewController: BaseViewController {

    
    @IBOutlet weak var godView: UIView!
    @IBOutlet weak var recordView: UIView!
    @IBOutlet weak var waitView: UIView!
    @IBOutlet weak var nearView: UIView!
    @IBOutlet weak var contentView: UIView!
    

    @IBAction func tap(_ sender: UITapGestureRecognizer) {
        
        if LoginStatus.isLogined == false {
            
            enterLogin()
            return
        }

        let tapView = sender.view!
            
        switch tapView {
        case godView: myCustomer()
        case nearView: near()
        default:
            break
        }
        
    
    }
}
fileprivate extension CRMViewController {
    
    // MARK: - 我的客户
    func myCustomer() {
        
        let myCustomerViewController = ECStroryBoard.controller(type: MyCustomerTableViewController.self)
        navigationController?.ecPushViewController(myCustomerViewController)
    }
    
    func near() {
        
        let nearViewController = ECStroryBoard.controller(type: NearMapViewController.self)
        navigationController?.ecPushViewController(nearViewController)
    }
}

