//
//  AddressBookAddPopViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/7.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AddressBookAddPopViewController: BaseTableViewController
{
   
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override var preferredContentSize: CGSize {
        get {
            
            if tableView != nil && presentingViewController != nil {
                var size = tableView.sizeThatFits(presentingViewController!.view.bounds.size)
                size.width = 100
                return size
            }
            
            return super.preferredContentSize
        }
        set { super.preferredContentSize = newValue }
    }
    
    
}
// MARK: - UITableView Delegate Datasource
extension AddressBookAddPopViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: print("添加")
        default: print("管理 ")
        }
        
        dismissVC(completion: nil)
    }
}
