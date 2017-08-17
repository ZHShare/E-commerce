//
//  ContactListTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/8/17.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

@objc protocol ContactListTableViewCellDelegate {
    func selected(model: Any?)
    func call(phone: String?)
}

class ContactListTableViewCell: UITableViewCell
{

    weak var delegate: ContactListTableViewCellDelegate?
  
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayHospatilName: UILabel!
    @IBOutlet weak var displayAddress: UILabel!
    @IBOutlet weak var selectedButton: UIButton!
    
    @IBAction func callPhone(sender: UIButton) {
        
        delegate?.call(phone: sender.currentTitle)
    }
    
    @IBAction func selected() {
     
        delegate?.selected(model: model)
    }
    
    var model: ContactListModel? {
        didSet { updateUI() }
    }
    
    var hospitalName: String? {
        didSet { self.displayHospatilName.text = hospitalName }
    }
    
    fileprivate func updateUI() {
        
        guard let model = model else {
            return
        }
        
        DispatchQueue.main.async {
            
            self.displayName.text = model.name
            self.displayAddress.text = model.address
            self.selectedButton.isSelected = model.isDefault
        }
    }

}
extension ContactListModel {
    var isDefault: Bool {
        return default_flag == "1" ? true : false
    }
}
