//
//  OrderListViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class OrderListViewController: BaseViewController
{

    @IBOutlet var tableView: UITableView!
    fileprivate var models: [OrderListModel]?
    fileprivate enum ReuseIdentifier {
        static let Order = "Order"
    }
    
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func fetchData() {
        
        models = OrderListModel.models()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigationBar()
        fetchData()
    }
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "我的订单"
    }

}
// MAKR: - UITableView Delegate Datasource
extension OrderListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let models = models {
            return models.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Order, for: indexPath)
        (cell as! OrderListTableViewCell).model = models?[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

