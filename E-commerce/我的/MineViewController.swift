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
    
    
}
// MARK: - MineHeaderDelegate
extension MineViewController: MineHeaderViewDelegate {
    
    func headerClick(imageView: UIImageView) {
        print(imageView)
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    
    // 待提交
    func submit() {
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    
    // 待审核
    func check() {
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    // 待发货
    func sending() {
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    
    // 待收货
    func consignee() {
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    
    // 待评价
    func evaluation() {
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    
    // 退款
    func returnedMoney() {
        if LoginStatus.isLogined == false { return enterLogin() }
    }
    
    // 更多订单
    func moreCoding() {
        if LoginStatus.isLogined == false { return enterLogin() }
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






