//
//  InvoiceManagerViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/9.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class InvoiceManagerViewController: BaseViewController
{

    @IBOutlet var tableView: UITableView!
    @IBOutlet var unIssunInvoiceButton: UIButton! {
        didSet { exchangeButton = unIssunInvoiceButton}
    }
    @IBOutlet var issueInvoiceButton: UIButton!
    
    @IBAction func issueInvoice(sender: UIButton) {
        
        exchangeButton.isSelected = false
        exchangeButton = sender
        exchangeButton.isSelected = true
        tableView.reloadData()
    }
    
    fileprivate var exchangeButton: UIButton!
    fileprivate enum ReuseIdentifier {
        static let IssunInvoice = "Issun Invoice"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }

    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
        
}
// MARK: - InvoiceManagerDelegate
extension InvoiceManagerViewController: InvoiceManagerDelegate {
    
    func didClickAgain(model: Any?) {
        
        let productDetailsController = ECStroryBoard.controller(type: MedicalProductDetailsViewController.self)
        navigationController?.ecPushViewController(productDetailsController)
    }
    
    func didClickApply(model: Any?) {
        
        let fillInvoiceViewController = ECStroryBoard.controller(type: SureInvoiceViewController.self)
        navigationController?.ecPushViewController(fillInvoiceViewController)
    }
}

// MARK: - UITableView delegate datasource
extension InvoiceManagerViewController: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.IssunInvoice, for: indexPath) as! IssunInvoiceTableViewCell
        
        cell.delegate = self
        if exchangeButton == issueInvoiceButton {
            cell.type = .BuyAgain
        }
        else {
            cell.type = .Apply
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        print("发票详情")
    }
}
