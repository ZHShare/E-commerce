//
//  SureInvoiceViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SureInvoiceViewController: BaseViewController
{

    @IBOutlet var tableView: UITableView!
    
    fileprivate var header: SureInvoiceHeader?
    fileprivate var isPersonal = true
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigationBar()
    }
   
    @IBAction func submit() {
        
        print("提交")
    }
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
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
}
// MARK: - UITableView delegate datasource
extension SureInvoiceViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return isPersonal ? 0 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Unit, for: indexPath)
        case 1: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Number, for: indexPath)
            (cell as! SureInvoiceTipTableViewCell).delegate = self
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if header == nil {
            header = ECStroryBoard.view(type: SureInvoiceHeader.self)
            header?.delegate = self
        }
        
        return header!
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footer = UIView()
        footer.backgroundColor = UIColor.groupTableViewBackground
        return footer
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
}
// MARK: - SureInvoiceTipTableViewCellDelegate 
extension SureInvoiceViewController: SureInvoiceTipTableViewCellDelegate {
    
    func tip() {
        
        print("识别号")
    }
}
// MARK: - SureInvoiceHeaderDelegate
extension SureInvoiceViewController: SureInvoiceHeaderDelegate {
    
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
