//
//  MineViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/26.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MineViewController: BaseTableViewController {
    
   
    fileprivate enum ReuseIdentifier {
        static let list = "Mine List"
    }
    
    var models: [MineModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        models = MineModel.models()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func configTableView() {
        
        if let tableHeader = tableView.tableHeaderView as? MineHeader {
            tableHeader.delegate = self
            tableHeader.demoClear()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
}
// MARK: - FilePrivate Func
fileprivate extension MineViewController {
    
    func myOrderList() {
        
        let myOrderController = ECStroryBoard.controller(type: OrderListViewController.self)
        navigationController?.ecPushViewController(myOrderController)
    }
}

// MARK: - MineHeaderDelegate
extension MineViewController: MineHeaderViewDelegate {
    
    func headerClick(imageView: UIImageView) {
        print(imageView)
        let detailsController = ECStroryBoard.controller(type: MineDetailsViewController.self)
        navigationController?.ecPushViewController(detailsController)
    }
    
    // 待提交
    func submit() {
        myOrderList()
    }
    
    // 待审核
    func check() {
        myOrderList()

    }
    // 待发货
    func sending() {
        myOrderList()

    }
    
    // 待收货
    func consignee() {
        myOrderList()

    }
    
    // 待评价
    func evaluation() {
        myOrderList()
    }
    
    // 退款
    func returnedMoney() {
        myOrderList()
    }
    
    // 更多订单
    func moreCoding() {
        myOrderList()
    }
    
}

// MARK: - Table view data source and delegate
extension MineViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let models = models {
            return models.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.list, for: indexPath)
        
        if let cell = cell as? MineCell {
            cell.model = models?[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    
    

}






