//
//  ShoppingCarViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/31.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ShoppingCarViewController: BaseViewController
{

    var models: [ShoppingModel]? {
        didSet { updateUI() }
    }
    
    fileprivate var allMoney = 0
    fileprivate var selectedAllModels = [ShoppingModel]()
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var displayMoney: UILabel!
    @IBOutlet weak var selectedAllButton: UIButton!
    
    fileprivate func fetchData() {
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.myShoppingCar, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            self.models = ShoppingModel.models(withDic: response)
        }
        
    }
    
    fileprivate var params: [String: Any] {
        return ["user_id": LoginModel.load()!.user_id]
    }
    
    fileprivate func updateUI() {
        
        if Thread.isMainThread {
            tableView.reloadData()
        }
        
        else {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func selectedAll(sender: UIButton) {
     
        if models == nil { return }
        
        sender.isSelected = !sender.isSelected
        
        let newModels = NSMutableArray()
        for model in models! {
            
            var model = model
            model.isSelected = sender.isSelected
            newModels.add(model)
        }
        
        models = newModels as? [ShoppingModel]
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        updateMoney()
    }
    
    @IBAction func settlenAccount() {
        
        let sureShoppingViewController = ECStroryBoard.controller(type: SureShoppingViewController.self)
        sureShoppingViewController.selectedProducts = getSelectedModels()
        navigationController?.ecPushViewController(sureShoppingViewController)
        
    }
    
    // MAKR: - 获取选中的商品
    fileprivate func getSelectedModels() -> [ShoppingModel] {
        
        var resultModels = [ShoppingModel]()
        guard let models = models else {
            return resultModels
        }
        
        for model in models {
            if model.isSelected {
                resultModels.append(model)
            }
        }
        return resultModels
    }
    
    fileprivate enum ReuseIdentifier {
        static let Shopping = "Shopping"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        fetchData()
    }
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "购物车"
    
        let editItem = UIBarButtonItem(title: "编辑", style: UIBarButtonItemStyle.plain, target: self, action: #selector(edit))
        editItem.tintColor = .black
        navigationItem.rightBarButtonItem = editItem
    }

    @objc fileprivate func edit() {
        
        print("编辑")
    }
}
// MARK: - ShoppingCarTableViewCellDelegate
extension ShoppingCarViewController: ShoppingCarTableViewCellDelegate {
    
    func didSelected(status: Bool, model: Any) {
        
        guard let model = model as? ShoppingModel else {
            return
        }
        let newModels = NSMutableArray()
        
        var allStatus = true
        for m in models! {
            
            var newModel = m
            if newModel == model {
                newModel.isSelected = status
            }
            
            if newModel.isSelected == false {
                allStatus = false
            }
            
            newModels.add(newModel)
        }
        
        // 更新全选按钮状态
        selectedAllButton.isSelected = allStatus
        
        // 更新数据源 不刷新
        models = newModels as? [ShoppingModel]
        
        updateMoney()
        
    }
    
    fileprivate func updateMoney() {
        
        allMoney = 0
        _ = models!.map({ (model) -> Void in
            
            if model.isSelected {
                allMoney += Int(model.sell_price)! * Int(model.goods_number)!
            }
        })
        
        if Thread.isMainThread {
            displayMoney.text = "\(allMoney)"
            
        }
        else {
            DispatchQueue.main.async {
                self.displayMoney.text = "\(self.allMoney)"
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension ShoppingCarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models == nil ? 0 : models!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Shopping, for: indexPath)
        
        (cell as! ShoppingCarTableViewCell).model = models?[indexPath.row]
        (cell as! ShoppingCarTableViewCell).delegate = self
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedModel = models![indexPath.row]
        let detailsViewController = ECStroryBoard.controller(type: MedicalProductDetailsViewController.self)
        detailsViewController.productID = selectedModel.product_id
        detailsViewController.selectedTypeString = selectedModel.product_attr
        detailsViewController.selectedCount = selectedModel.goods_number
        navigationController?.ecPushViewController(detailsViewController)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除"
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        let alertController = UIAlertController(title: nil, message: "确定删除？", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.default, handler: { (act) in
            
            self.removeSelectedIndexPath(indexPath: indexPath)
        }))
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
     
        presentVC(alertController)
        
    }
    
    fileprivate func removeSelectedIndexPath(indexPath: IndexPath) {
        
        let selectedModel = models![indexPath.row]

        let parms: [String: Any] = ["list": [["user_id": LoginModel.load()!.user_id, "product_id": selectedModel.product_id]]]
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.delShoppingCar, params: parms) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            var newModels = self.models!
            newModels.remove(at: indexPath.row)
            self.models = newModels
            self.updateMoney()
        }
    }
}
