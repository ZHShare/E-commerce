//
//  AccountDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import EZSwiftExtensions

class AccountDetailsViewController: BaseViewController {

    var account_id: String? = ""
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var displayYearAndMonth: UILabel! {
        didSet { updateTotalUI() }
    }
    @IBOutlet weak var displayAllMoney: UILabel!
    
    fileprivate func updateTotalUI() {
        
        let currentData = Date().toString(format: "yyyy年MM月")
        displayYearAndMonth.text = currentData
    }
    
    fileprivate var models: [AccountDetailsModel]?
    fileprivate var params: [String: Any] = ["user_id": LoginModel.load() == nil ? "" : LoginModel.load()!.user_id,
                                             "bill_data": Date().toString(format: "yyyyMMdd")]
   
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

        params["account_id"] = account_id == nil ? "" : account_id!
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.myAccountDetails, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let newModels = AccountDetailsModel.models(withDic: response)
            self.models = newModels?.1
            
            DispatchQueue.main.async {
                self.displayAllMoney.text = newModels?.0
                self.tableView.reloadData()
            }
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
        picker.type = .Day
        UIApplication.shared.keyWindow?.addSubview(picker)
        picker.dateChose = { (date) in
            
            self.displayYearAndMonth.text = Date(fromString: date, format: "yyyyMM")?.toString(format: "yyyy年MM月")
            self.params["bill_data"] = "\(date)00"
            self.fetchData()
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
