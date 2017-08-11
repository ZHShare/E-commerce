//
//  SureInvoiceTableFooter.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SureInvoiceTableFooter: UIView
{

  
    @IBOutlet var contentField: UITextField!
    fileprivate let maxLength = 50
    
    @IBAction func clear() {
        contentField.text = ""
    }

    @IBAction func selectedAddress() {
        
        addressButton.setTitle("湖南省 长沙市 岳麓区", for: .normal)
    }
    @IBOutlet weak var addressButton: UIButton!
    @IBAction func clearAddressField() {
        detailsAddressField.text = ""
    }
    @IBOutlet weak var detailsAddressField: UITextField!
    
}


