//
//  UnissunInvoiceTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/9.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

enum InvoiceManagerType {
    case BuyAgain
    case Apply
}

protocol InvoiceManagerDelegate {
    
    func didClickApply(model: Any?)
    func didClickAgain(model: Any?)
}

class IssunInvoiceTableViewCell: UITableViewCell
{

    var type: InvoiceManagerType = .Apply {
        didSet { updateApplyTitle() }
    }
    var delegate: InvoiceManagerDelegate?
    
    @IBOutlet weak var displayTitle: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var displayProduceName: UILabel!
    @IBOutlet weak var displayRemark: UILabel!
    @IBOutlet weak var displayAmount: UILabel!
    @IBOutlet weak var applyButton: UIButton!
    
    @IBOutlet weak var displayAllPrice: UILabel!
    @IBOutlet weak var displayPrice: UILabel!
    @IBAction func apply() {
       
        switch type {
        case .Apply: delegate?.didClickApply(model: nil)
        default:
            delegate?.didClickAgain(model: nil)
        }
    }

    fileprivate func updateApplyTitle() {
    
        switch type {
        case .Apply: applyButton.setTitle("申请开票", for: .normal)
        default:
            applyButton.setTitle("再次购买", for: .normal)
        }
        
    }
    
}
