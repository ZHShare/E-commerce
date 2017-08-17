//
//  MyCustomerTableViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

enum MyCustomerType {
    case Default
    case Selected
}

class MyCustomerTableViewController: BaseTableViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configSearchController()
        fetchData()
    }
    
    var type: MyCustomerType = .Default
    
    fileprivate var searchResults: [MyCustomerModel]?
    fileprivate var datas: [MyCustomerModel]?
    fileprivate var searchController: UISearchController!

    fileprivate enum ReuseIdentifier {
        static let MyCustomer = "My Customer"
    }
    
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        let addCustomerViewController = ECStroryBoard.controller(type: CustomerNewViewController.self)
        navigationController?.ecPushViewController(addCustomerViewController)
    }
    
    func fetchData() {
        
        let params: [String: Any] = ["user_id": LoginModel.load()!.user_id]
        
        CRMNet.fetchDataWith(transCode: TransCode.CRM.customerList, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.datas = MyCustomerModel.models(withDic: response)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    fileprivate func configSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.barTintColor = UIColor.groupTableViewBackground
        searchController.searchBar.placeholder = "搜索客户"
        searchController.disablesAutomaticKeyboardDismissal = false
        searchController.dimsBackgroundDuringPresentation = false
        
        searchController.searchBar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: Screen.width, height: tableView!.tableHeaderView!.frame.size.height))
 
        definesPresentationContext = true
        
        // 取消按钮文字
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "取消"
        
        tableView.tableHeaderView?.addSubview(searchController.searchBar)
        
    }
    
    fileprivate func imageWithColor(color: UIColor, size: CGSize) -> UIImage? {
        
        let rect = CGRect(x: 0, y: 0, w: size.width, h: size.height)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
    
}
// MARK: - UISearchControllerDelegate, UISearchResultsUpdating
extension MyCustomerTableViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
      
        let searchText = searchController.searchBar.text!
        var results = [MyCustomerModel]()
        searchResults = nil
        if datas != nil {
            for model in datas! {
                
                if model.cust_name.contains(searchText) {
                    results.append(model)
                }
            }
            searchResults = results
        }
        tableView.reloadData()
    }
    
    
}

// MARK: UITableView Delegate Datasource
extension MyCustomerTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchController.isActive ? (searchResults == nil ? 0 : searchResults!.count) : (datas == nil ? 0 : datas!.count)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.MyCustomer, for: indexPath)
        
        if searchController.isActive {
            (cell as! MyCustomerTableViewCell).model = searchResults?[indexPath.row]
        }
        else {
            (cell as! MyCustomerTableViewCell).model = datas?[indexPath.row]
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let contactListViewController = ECStroryBoard.controller(type: ContactListViewController.self)
        let selectedModel = searchController.isActive ? searchResults![indexPath.row] : datas![indexPath.row]
        contactListViewController.type = type
        contactListViewController.model = selectedModel
        navigationController?.ecPushViewController(contactListViewController)
        
    }
    
}
