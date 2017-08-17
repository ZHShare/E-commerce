//
//  SureShoppingViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/1.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit



class SureShoppingTableViewController: BaseTableViewController
{
    var selectedProducts: [ShoppingModel]?
    var addressModel: ContactListModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    fileprivate enum ReuseIdentifier {
        static let Address = "Address"
        static let Product = "Product"
        static let Field = "Field"
    }

    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
  
    
}
// MARK: - SureShoppingAddressTableViewCellDelegate
extension SureShoppingTableViewController: SureShoppingAddressTableViewCellDelegate {
    
    func selected() {
        
        let myCustomerViewController = ECStroryBoard.controller(type: MyCustomerTableViewController.self)
        myCustomerViewController.type = .Selected
        navigationController?.ecPushViewController(myCustomerViewController)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SureShoppingTableViewController {
    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return selectedProducts == nil ? 0 : selectedProducts!.count
        default: return 1
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Address, for: indexPath)
            (cell as! SureShoppingAddressTableViewCell).model = addressModel
            (cell as! SureShoppingAddressTableViewCell).delegate = self
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Product, for: indexPath)
            (cell as! SureShoppingProductTableViewCell).model = selectedProducts?[indexPath.row]
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Field, for: indexPath)
            
        default: cell = UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
   
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}
