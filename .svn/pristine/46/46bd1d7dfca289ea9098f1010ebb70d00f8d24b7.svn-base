//
//  MyAccountViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MyAccountViewController: BaseTableViewController
{

    fileprivate enum ReuseIdentifier {
        static let Record = "Record"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
   
    
    fileprivate func configNavigationBar() {
        navigationItem.title = "我的账户"
    }

}
// MARK: - UITableView Delegate Datasource
extension MyAccountViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Record, for: indexPath)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let accountDetailsController = ECStroryBoard.controller(type: AccountDetailsViewController.self)
        navigationController?.ecPushViewController(accountDetailsController)
    }
    
}
