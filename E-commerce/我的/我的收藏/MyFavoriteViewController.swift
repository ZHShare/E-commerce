//
//  MyFavoriteViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import MJRefresh

class MyFavoriteViewController: BaseViewController
{

    @IBOutlet weak var header: UIView!
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var typeTableView: UITableView!
    @IBOutlet weak var tipView: UIView!
    @IBAction func all(_ sender: Any) {
        
        showTypeTableView()
    }
    @IBAction func hiddenType(_ sender: Any) {
    
        hiddenTypeTableView()
    }
    
    fileprivate let mjHeader = MJRefreshNormalHeader()
    fileprivate let mjFooter = MJRefreshAutoNormalFooter()
    fileprivate var products: [MyFavoriteModel]?
    fileprivate var types: [FirstClassifyModel]? {
        didSet { updateTypeTableView() }
    }
    fileprivate var pageNumber = 1 {
        didSet { fetchData() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        hiddenTypeTableView()
        configTableView()
        mjHeader.beginRefreshing()
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).asyncAfter(deadline: DispatchTime.now()+0.5) { [unowned self] in
            self.fetchDataForType()
        }
    }
    
    
    fileprivate var params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                             "type": "1"]
    fileprivate func fetchData() {
        
        params["page_num"] = "\(pageNumber)"
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.myFavorite, params: params) { (response, isLoadFaild, errorMsg) in
            
            self.endRefreshing()
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let newProducts = MyFavoriteModel.models(withDic: response)
            if self.pageNumber == 1 {
                self.products = newProducts
            }
            else {
                
                if newProducts != nil && newProducts?.count != 0 {
                    self.products!.append(contentsOf: newProducts!)
                }
            }
            
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
        
       
    }
    
    fileprivate func updateTypeTableView() {
        
        DispatchQueue.main.async {
            
            self.typeTableView.reloadData()
        }
    }
    
    fileprivate func fetchDataForType() {
        
        HomeNet.fetchDataWith(transCode: TransCode.Home.firstClass, params: [String : Any]()) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            if let models = FirstClassifyModel.models(withDic: response) {
                
                self.types = models
            }
            
        }
        
    }
    
    fileprivate func configTableView() {
        
        mainTableView.mj_footer = mjFooter
        mainTableView.mj_header = mjHeader
        
        mjHeader.refreshingBlock = {
            self.pageNumber = 1
        }
        
        mjFooter.refreshingBlock = {
            self.pageNumber += 1
        }
    }
    
    fileprivate func endRefreshing() {
        
        if Thread.isMainThread {
            
            if mjFooter.isRefreshing() {
                mjFooter.endRefreshing()
            }
            
            if mjHeader.isRefreshing() {
                mjHeader.endRefreshing()
            }
        }
        
        else {
            
            DispatchQueue.main.async {
                
                if self.mjFooter.isRefreshing() {
                    self.mjFooter.endRefreshing()
                }
                
                if self.mjHeader.isRefreshing() {
                    self.mjHeader.endRefreshing()
                }
            }
        }
    }
    
    fileprivate enum ReuseIdentifier {
        static let ListType = "ListType"
        static let Product = "Product"
    }
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "收藏夹"
    }
}
// MARK: - UITableViewDelegate Datasource
extension MyFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case mainTableView: return products == nil ? 0 : products!.count
        case typeTableView: return types == nil ? 0 : types!.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch tableView {
        case mainTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Product, for: indexPath)
            (cell as! MyFavoriteTableViewCell).model = products?[indexPath.row]
        case typeTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.ListType, for: indexPath)
            (cell as! MyFavoriteTypeTableViewCell).model = types?[indexPath.row]
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = UIColor.groupTableViewBackground
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch tableView {
        case typeTableView:
            let selectedType = types![indexPath.row]
            params["cat_id"] = selectedType.cat_id
            mjHeader.beginRefreshing()
            hiddenTypeTableView()
        default:
            let model = products![indexPath.row]
            let productDetailsViewController = ECStroryBoard.controller(type: MedicalProductDetailsViewController.self)
            productDetailsViewController.productID = model.product_id
            navigationController?.ecPushViewController(productDetailsViewController)
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if tableView == mainTableView{
            return true
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        return "移除"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: nil, message: "确定移除？", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (act) in
            
            self.removeFromIndexPath(indexPath: indexPath)
        }))
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        
        presentVC(alertController)
        
    }
    
    fileprivate func removeFromIndexPath(indexPath: IndexPath) {
        
        let product = products![indexPath.row]
     
        let params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                     "product_id": product.product_id]
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.removeFav, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudForWindowsWithMessage(msg: errorMsg)
            }
           
            super.hudForWindowsWithMessage(msg: "已移除")
            var newModels = self.products!
            newModels.remove(at: indexPath.row)
            self.products = newModels
            DispatchQueue.main.async {
                self.mainTableView.reloadData()
            }
        }
    }
    
}
// MARK: - FilePrivate
extension MyFavoriteViewController {
    
    // MARK: - Show Type List
    func showTypeTableView() {
        
        if self.tipView.frame.origin.y == self.header.bottom {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            self.tipView.frame.origin.y = self.header.bottom

        }, completion: nil)
    }
    
    // MARK: - hidden Type List
    func hiddenTypeTableView() {
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            self.tipView.frame.origin.y = self.mainTableView.bottom
        }, completion: nil)
    }
}
