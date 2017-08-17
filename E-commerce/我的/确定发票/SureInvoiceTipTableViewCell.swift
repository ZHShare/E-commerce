//
//  SureInvoiceTipTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol SureInvoiceTipTableViewCellDelegate {
    
    func tip()
}

class SureInvoiceTipTableViewCell: UITableViewCell
{

    weak var delegate: SureInvoiceTipTableViewCellDelegate?
    @IBOutlet var tipButton: UIButton!
    @IBOutlet var numberField: UITextField!
    
    fileprivate let maxLength = 20
    @IBAction func tip() {
        
        delegate?.tip()
    }
    
}
