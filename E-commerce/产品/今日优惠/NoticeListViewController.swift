//
//  NoticeListViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/16.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class NoticeListViewController: BaseViewController
{
    
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {configTableView()}
    }
    @IBOutlet weak var discountButton: UIButton! {
        didSet {exchangeButton = discountButton}
    }
    @IBOutlet weak var referralInformationButton: UIButton!
    
    fileprivate var exchangeButton: UIButton!
    
    @IBAction func topAction(sender: UIButton) {
        
        exchangeButton.isSelected = false
        exchangeButton = sender
        exchangeButton.isSelected = true
        
        fetchDataWithType(type: "\(sender.tag)")
        
    }
    
    fileprivate var models: [NoticeListModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDataWithType(type: "1")
    }

    fileprivate func fetchDataWithType(type: String) {
        
        let params: [String: Any] = ["type": type]
        HomeNet.fetchDataWith(transCode: TransCode.Home.publicNotice, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.models = NoticeListModel.models(withResponse: response)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate enum ReuseIdentifier {
        static let ProductDiscount = "Product Discount"
    }

    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
}
// MARK: - UITableView Delegate Datasource
extension NoticeListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models == nil ? 0 : models!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.ProductDiscount, for: indexPath)
        
        (cell as! NoticeListTableViewCell).model = models?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedModel = self.models![indexPath.row]
        if selectedModel.notice_type == "1" {
            
            let productDetailsViewController = ECStroryBoard.controller(type: MedicalProductDetailsViewController.self)
            productDetailsViewController.productID = selectedModel.notice_id
            navigationController?.ecPushViewController(productDetailsViewController)
        }
        else {
            
            let detailsViewController = ECStroryBoard.controller(type: NoticeDetailsViewController.self)
            detailsViewController.notice_id = selectedModel.notice_id
            navigationController?.ecPushViewController(detailsViewController)
        }
        
    }
}
