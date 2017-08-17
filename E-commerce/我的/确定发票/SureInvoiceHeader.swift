//
//  SureInvoiceHeader.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol SureInvoiceHeaderDelegate {
    
    func didClick(type: SureInvoiceHeaderType)
}

@objc enum SureInvoiceHeaderType: Int {
    case Personal
    case Unit
}

class SureInvoiceHeader: UIView
{

    weak var delegate: SureInvoiceHeaderDelegate?
    fileprivate var type = SureInvoiceHeaderType.Personal
    fileprivate var exchangeButton: UIButton!
    @IBOutlet weak var unitButton: UIButton!
    @IBOutlet weak var personalButton: UIButton! {
        didSet {
            exchangeButton = personalButton
        }
    }
    @IBAction func invoice(_ sender: UIButton) {
        
        exchangeButton.isSelected = false
        exchangeButton = sender
        exchangeButton.isSelected = true
        
        if exchangeButton == unitButton {
            type = .Personal
        }
        else {
            type = .Unit
        }
        
        delegate?.didClick(type: type)
    }

}
