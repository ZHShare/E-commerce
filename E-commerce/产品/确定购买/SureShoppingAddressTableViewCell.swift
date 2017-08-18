//
//  SureShoppingAddressTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/1.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol SureShoppingAddressTableViewCellDelegate {
    
    func selected()
}


class SureShoppingAddressTableViewCell: UITableViewCell
{
    var model: ContactListModel? {
        didSet { updateUI() }
    }
    
    weak var delegate: SureShoppingAddressTableViewCellDelegate?
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayPhone: UILabel!
    @IBOutlet weak var displayAddress: UILabel!

    @IBOutlet weak var showView: UIView!
    
    fileprivate func updateUI() {
        
        guard let model = model else {
            showView.alpha = 1
            return
        }
        
        showView.alpha = 0
        DispatchQueue.main.async {
            self.displayName.text = model.name
            self.displayPhone.text = model.mobile.length == 0 ? model.phone : model.mobile
            self.displayAddress.text = model.cust_address
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addTapGesture { [unowned self](tap) in
            
            self.delegate?.selected()
        }
    }
    
}
