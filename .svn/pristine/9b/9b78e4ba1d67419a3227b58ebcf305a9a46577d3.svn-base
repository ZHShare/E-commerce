//
//  OrderDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

enum OrderType {
    case Fill
    case Done
}

class OrderDetailsViewController: BaseViewController
{

    var orderType: OrderType =  .Fill { didSet { updateBar() } }
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var abountOfProductButton: UIButton!
    @IBOutlet weak var goEvaluationButton: UIButton!
    @IBOutlet weak var fillInvoiceInfoButton: UIButton!
   
    @IBAction func aboutOfProduct() {
        
        print("相关产品")
    }

    @IBAction func goEvaluation() {
        print("去评价")
    }
    
    @IBAction func fillInvoiceInfo() {
        
        let fillInvoiceViewController = ECStroryBoard.controller(type: SureInvoiceViewController.self)
        navigationController?.ecPushViewController(fillInvoiceViewController)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateBar()
        configTableView()
        configNavigationBar()
    }
    
    fileprivate func updateBar() {
        
        switch orderType {
        case .Fill:
            goEvaluationButton?.removeFromSuperview()
            abountOfProductButton?.removeFromSuperview()
        default:
            fillInvoiceInfoButton?.removeFromSuperview()
        }
        
    }
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "订单详情"
    }
    
    fileprivate enum ReuseIdentifier {
        static let Product = "Product"
        static let Addresse = "Address"
        static let Date = "Date"
        static let Invoice = "Invoice"
    }
    
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}
// MARK: - UITableView Delegate Datasource
extension OrderDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch indexPath.row {
        case 0: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Product, for: indexPath)
        case 1: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Addresse, for: indexPath)
        case 2: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Date, for: indexPath)
        case 3: cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Invoice, for: indexPath)
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
