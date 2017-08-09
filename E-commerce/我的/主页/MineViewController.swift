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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        configTableView()
        addNotice()
    }
    
    deinit {
        removeNotice()
    }
    
    fileprivate func addNotice() {
        
        UserInfo.addObserver(observer: self, selector: #selector(notice(notice:)), notification: UserInfo.Notification.Update)
    }
    
    fileprivate func removeNotice() {
        
        UserInfo.removeObserver(observer: self, notification: UserInfo.Notification.Update)
    }
    
    @objc fileprivate func notice(notice: Notification) {
        
        updateUI()
    }
    
    fileprivate func configTableView() {
        
        if let tableHeader = tableView.tableHeaderView as? MineHeader {
            tableHeader.delegate = self
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
        
        if LoginStatus.isLogined {
            
            let myOrderController = ECStroryBoard.controller(type: OrderListViewController.self)
            navigationController?.ecPushViewController(myOrderController)
            return
        }
        
        enterLogin()
    }
}

// MARK: - MineHeaderDelegate
extension MineViewController: MineHeaderViewDelegate {
    
    func headerClick(imageView: UIImageView) {
        
        if LoginStatus.isLogined {
            
            let detailsController = ECStroryBoard.controller(type: MineDetailsViewController.self)
            navigationController?.ecPushViewController(detailsController)
            return
        }
        
        enterLogin()
        
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
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let cell = tableView.cellForRow(at: indexPath)!
        switch cell.tag {
        case 1000: didClickAccount()
        case 1001: didClickShopping()
        case 1002: didCLickMyFavorite()
        case 1003: didClickInvoice()
        case 1005: didClickAddressBook()
        case 1007: didClickSetting()
        default:
            break
        }
        
    }
    
    

}
// MARK: - FilePrivate 
fileprivate extension MineViewController {
    
    // MARK: did click invoice manager
    fileprivate func didClickInvoice() {
        
        let invoiceManagerViewController = ECStroryBoard.controller(type: InvoiceManagerViewController.self)
        navigationController?.ecPushViewController(invoiceManagerViewController)
    }
    
    // MARK: update UI
    fileprivate func updateUI() {
        
        if LoginStatus.isLogined {
            
            if let header = tableView.tableHeaderView as? MineHeader {
                header.updateUI()
            }
        }
        else {
            if let header = tableView.tableHeaderView as? MineHeader {
                header.demoClear()
            }
        }
    }
    
    // MARK: - click shopping
    func didClickShopping() {
        
        if LoginStatus.isLogined {
            let shoppingCarViewController = ECStroryBoard.controller(type: ShoppingCarViewController.self)
            navigationController?.ecPushViewController(shoppingCarViewController)
        }
        else {
            enterLogin()
        }
        
    }
    
    // MARK: - click my favorite
    func didCLickMyFavorite()  {
    
        if LoginStatus.isLogined {
            let myFavoriteViewController = ECStroryBoard.controller(type: MyFavoriteViewController.self)
            navigationController?.ecPushViewController(myFavoriteViewController)
        }
        else {
            enterLogin()
        }
    }
    
    // MARK: - click account 
    func didClickAccount() {
        
        if LoginStatus.isLogined {
            let myAccountController = ECStroryBoard.controller(type: MyAccountViewController.self)
            navigationController?.ecPushViewController(myAccountController)
        }
        else {
            enterLogin()
        }
    }
    
    // MARK: - click setting 
    func didClickSetting() {
        
        let settingViewController = ECStroryBoard.controller(type: SettingViewController.self)
        navigationController?.ecPushViewController(settingViewController)
    }
    
    // MARK: - click address book 
    func didClickAddressBook() {
    
        if LoginStatus.isLogined {
            let addressBookViewController = ECStroryBoard.controller(type: AddressBookViewController.self)
            navigationController?.ecPushViewController(addressBookViewController)
        }
        else {
            enterLogin()
        }
    }
}






