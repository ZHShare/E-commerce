//
//  AccountDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit


class AccountDetailsViewController: BaseViewController {

    @IBOutlet var tableView: UITableView!
    
    fileprivate var models: [AccountDetailsModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        configTableView()
        fetchData()
    }
    
    fileprivate enum ReuseIdentifier {
        static let Details = "Account Details"
    }
    
    fileprivate func fetchData() {
        models = AccountDetailsModel.models()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    fileprivate func configNavigationBar() {
        
        navigationItem.title = "收支明细"
        
        let dateItem = UIBarButtonItem(image: UIImage(named: "mine_my_account_date"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(dateClick))
        dateItem.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = dateItem
    }

    @objc fileprivate func dateClick() {
        
        let picker = ECStroryBoard.view(type: MiniDetailsDatePicker.self)
        UIApplication.shared.keyWindow?.addSubview(picker)
        picker.dateChose = { (date) in
            print(date)
        }
    }
    
}
// MARK: - UITableView Delegate Datasource
extension AccountDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let models = models {
            return models.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Details, for: indexPath)
        (cell as! AccountDetailsTableViewCell).model = models?[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
