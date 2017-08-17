//
//  InvoiceManagerTablViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/11.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SureInvoiceTablViewController: UITableViewController {

    
    fileprivate var header: SureInvoiceHeader?
    fileprivate var isPersonal = false
    
    fileprivate enum ReuseIdentifier {
        static let Unit = "Unit"
        static let Number = "Number"
    }
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "确认发票"
    }
    @IBAction func tap(_ sender: Any) {
        
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
// MARK: - InvoiceManagerDelegate
// MARK: - SureInvoiceTipTableViewCellDelegate
extension SureInvoiceTablViewController: SureInvoiceTipTableViewCellDelegate {
    
    func tip() {
        
        print("识别号")
    }
}
// MARK: - SureInvoiceHeaderDelegate
extension SureInvoiceTablViewController: SureInvoiceHeaderDelegate {
    
    func didClick(type: SureInvoiceHeaderType) {
        switch type {
        case .Personal: isPersonal = true
        default:
            isPersonal = false
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
extension SureInvoiceTablViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isPersonal ? 0 : 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Unit, for: indexPath)
        case 1: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Number, for: indexPath)
        (cell as! SureInvoiceTipTableViewCell).delegate = self
        default: break
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if header == nil {
            header = ECStroryBoard.view(type: SureInvoiceHeader.self)
            header?.delegate = self
        }
        
        return header!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = UIView()
        footer.backgroundColor = UIColor.groupTableViewBackground
        return footer
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

}
