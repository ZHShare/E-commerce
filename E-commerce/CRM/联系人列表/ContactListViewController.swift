//
//  ContactListViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/17.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit


class ContactListViewController: BaseTableViewController
{
    var type: MyCustomerType = .Default
    var model: MyCustomerModel?
    
    fileprivate var datas: [ContactListModel]?
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        fetchData()
    }

    fileprivate enum ReuseIdentifier {
        static let Contact = "Contact List"
    }

    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func fetchData() {
        
        if model == nil { return }
        
        let params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                    "cust_no": model!.cust_no]
        CRMNet.fetchDataWith(transCode: TransCode.CRM.contactList, params: params) { [unowned self](response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return self.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.datas = ContactListModel.models(withResponse: response)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        let contactNewController = ECStroryBoard.controller(type: ContactNewViewController.self)
        contactNewController.cust_no = model?.cust_no
        self.navigationController?.ecPushViewController(contactNewController)
    }
}
// MARK: - UITableView Delegate Datasource
extension ContactListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas == nil ? 0 : datas!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Contact, for: indexPath)
        (cell as! ContactListTableViewCell).model = datas?[indexPath.row]
        (cell as! ContactListTableViewCell).hospitalName = model?.cust_name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch type {
        case .Selected:
            let seModel = datas![indexPath.row]
            SureShopping.postNotification(notification: SureShopping.Notification.Address, userInfo: ["model": seModel as AnyObject])
            popToViewController()
        default:
            print("联系人详情")
        }
    }
    
    fileprivate func popToViewController() {
        
        let viewControllers = navigationController!.viewControllers
        for vc in viewControllers {
            if vc.isKind(of: SureShoppingViewController.classForCoder()) {
                navigationController?.ecPopToViewController(viewController: vc)
            }
        }
    }
}
