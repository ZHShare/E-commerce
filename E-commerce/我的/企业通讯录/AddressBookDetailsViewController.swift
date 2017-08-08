//
//  AddressBookDetailsViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/8/8.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AddressBookDetailsViewController: BaseTableViewController
{
    @IBOutlet weak var displayPhoneNumber: UILabel!
    @IBOutlet weak var displayDepartment: UILabel!
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayCompany: UILabel!
    @IBOutlet weak var displaySex: UIImageView!
    @IBAction func sendMessage() {
    }
    @IBAction func voiceMessage() {
    }

    var model: AddressBookModel? {
        didSet { updateUI() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    fileprivate func updateUI() {
        
        displayPhoneNumber?.text = model?.mobile
        displaySex?.image = model?.sexImage
        icon?.sd_setImage(with: URL(string: model!.head_portrait), placeholderImage: UIImage(named: "log_reg_icon"))
        displayName?.text = model?.name
        displayCompany?.text = model?.enterprise_name
        displayDepartment?.text = model?.department_name
    }

}
extension AddressBookModel {
    
    var sexImage: UIImage? {
        
        switch sex {
        case "1": return UIImage(named: "mine_sex_man")
        case "2": return UIImage(named: "mine_sex_women")
        default:  return UIImage(named: "mine_sex_women")
        }
    }
    
    var header: UIImage? {
        
        return UIImage(named: head_portrait)
    }
}
