//
//  SureInvoiceHeader.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

protocol SureInvoiceHeaderDelegate {
    
    func didClick(type: SureInvoiceHeaderType)
}

enum SureInvoiceHeaderType {
    case Personal
    case Unit
}

class SureInvoiceHeader: UIView
{

    var delegate: SureInvoiceHeaderDelegate?
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
