//
//  SureInvoiceTableHeader.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

enum InvoiceType {
    case Page
    case Electron
    case VAT
}

protocol SureInvoiceTableHeaderDelegate {
    func didClickType(type: InvoiceType)
}

class SureInvoiceTableHeader: UIView
{
    fileprivate var exchangeButton: UIButton!
    fileprivate var type: InvoiceType = .Page
    
    @IBOutlet var pageButton: UIButton! { didSet { exchangeButton = pageButton } }
    @IBOutlet var electronButton: UIButton!
    @IBOutlet var VATButton: UIButton!
    
    var delegate: SureInvoiceTableHeaderDelegate?
    
    @IBAction func invoiceClick(sender: UIButton) {
        
        exchangeButton.isSelected = false
        exchangeButton = sender
        exchangeButton.isSelected = true
        
        switch sender.currentTitle! {
        case "纸质发票": type = .Page
        case "电子发票": type = .Electron
        case "增值税发票": type = .VAT
        default: break
        }
        
        delegate?.didClickType(type: type)
    }
    
}
