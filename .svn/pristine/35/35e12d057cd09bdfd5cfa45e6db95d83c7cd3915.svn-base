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
        
        if let tapView = sender.view {
            print("\(tapView)")
        }
        
        if LoginStatus.isLogined { return }
        enterLogin()
    }
}

