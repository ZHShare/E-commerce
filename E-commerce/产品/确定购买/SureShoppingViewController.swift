//
//  SureShoppingViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/17.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit


enum ShoppingType {
    case Car
    case BuyNow
}

class SureShopping: Nofifier {
    enum Notification: String {
        case Address
    }
}

class SureShoppingViewController: BaseViewController
{

    var shoppingType: ShoppingType = .Car
    var selectedProducts: [ShoppingModel]?
    var addressModel: ContactListModel?

    fileprivate var tableView: UITableView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var displayAllMoney: UILabel!
    @IBAction func submit() {
        
        if addressModel == nil {
            return super.hudForWindowsWithMessage(msg: "请选择一个联系人")
        }
        
        let title = "是否确定提交此订单"
        let sure = "确定"
        let cancel = "取消"
    
        let alertController = UIAlertController(title: nil, message: title, preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: sure, style: UIAlertActionStyle.default, handler: { (act) in
            
            self.orddingSubmit()
        }))
        alertController.addAction(UIAlertAction(title: cancel, style: UIAlertActionStyle.cancel, handler: nil))
        presentVC(alertController)
    }
    
    fileprivate func orddingSubmit() {
        
        var params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                     "cust_no": addressModel!.cust_no,
                                     "receiver_detail_address": addressModel!.cust_address,
                                     "order_total_amount": "\(getAllMoney())",
                                     "product_total_amount": "\(getAllMoney())",
                                     "iffe_total_amount": "0",
                                     "pay_mode": "3",
                                     "user_comments": tableVC.fieldText ?? "",
                                     "receiver_mobile": addressModel!.mobile,
                                     "receiver_name": addressModel!.name,
                                     "order_mode": shoppingType == .BuyNow ? "1" : "2"]
        
        var lists = [Any]()
        for product in selectedProducts! {
            
            var productDic = [String: Any]()
            productDic["product_id"] = product.product_id
            productDic["goods_number"] = product.goods_number
            productDic["product_attr"] = product.product_attr
            productDic["product_price"] = product.sell_price
            
            lists.append(productDic)
        }
        
        params["list"] = lists
        
        HomeNet.fetchDataWith(transCode: TransCode.Home.sureShopping, params: params) { [unowned self](response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return self.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            let order_id = (response["data"] as? [String: String])?["order_id"]
            let resultsViewController = ECStroryBoard.controller(type: ShoppingResultsViewController.self)
            resultsViewController.order_id = order_id
            self.navigationController?.ecPushViewController(resultsViewController)
            
        }
    }
    
    fileprivate var allMoney: Int {
        
        set {
            displayAllMoney.text = "¥\(newValue).00"
        }
        
        get {
            return displayAllMoney.text!.toInt()!
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        refreshTableView()
        addNotice()
    }

    fileprivate let tableVC = ECStroryBoard.controller(type: SureShoppingTableViewController.self)
    
    fileprivate func configTableView() {
        
        addChildViewController(tableVC)
        tableView = tableVC.tableView
        topView.addSubview(tableView)
        topView.clipsToBounds = true
        tableView.frame.size.width = topView.frame.size.width
        tableView.frame.size.height = topView.frame.size.height
        
    }
    
    fileprivate func refreshTableView() {
        
        if let footer: SureShoppingFooter = tableView.tableFooterView as? SureShoppingFooter {
            footer.allCount = getAllCount()
            footer.money = getAllMoney()
        }
        
        allMoney = getAllMoney()
        
        tableVC.selectedProducts = selectedProducts
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }
    }
    
    // MARK: - 共多少件商品
    fileprivate func getAllCount() -> Int {
        
        if selectedProducts == nil {
            return 0
        }
        
        var count = 0
        for model in selectedProducts! {
            
            count += model.goods_number.toInt()!
        }
        return count
    }
    
    // MARK: 共多少金额
    fileprivate func getAllMoney() -> Int {
        
        if selectedProducts == nil {
            return 0
        }
        
        var price = 0
        for model in selectedProducts! {
            
            price += model.goods_number.toInt()!*model.sell_price.toInt()!
        }
        
        return price
    }
    
    deinit {
        removeNotice()
    }
    
    fileprivate func addNotice() {
        
        SureShopping.addObserver(observer: self, selector: #selector(notice(notice:)), notification: SureShopping.Notification.Address)
    }
    
    fileprivate func removeNotice() {
        
        SureShopping.removeObserver(observer: self, notification: SureShopping.Notification.Address)
    }
    
    @objc fileprivate func notice(notice: Notification) {
        
        let userInfo = notice.userInfo
        if let model = userInfo?["model"] as? ContactListModel {
            addressModel = model
            tableVC.addressModel = model
            DispatchQueue.main.async {
                
                let sectionOneIndexSet = NSIndexSet(index: 0) as IndexSet
                self.tableView.reloadSections(sectionOneIndexSet, with: UITableViewRowAnimation.none)
            }
        }
    }
}
