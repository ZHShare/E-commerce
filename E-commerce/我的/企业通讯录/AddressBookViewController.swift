//
//  AddressBookViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/7.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AddressBookViewController: BaseTableViewController
{

    fileprivate var indexArray: [NSArray]?
    fileprivate var letterArray: [String]?
    
    fileprivate enum ReuseIdentifier {
        static let AddressBook = "Address Book"
        static let Pop = "Add"
    }
  
    fileprivate var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configSearchController()
        fetchData()
    }

    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.sectionIndexBackgroundColor = UIColor.clear
    }

    fileprivate func configSearchController() {
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        
        searchController.searchBar.barTintColor = UIColor.groupTableViewBackground
        searchController.searchBar.placeholder = "搜索联系人"
        searchController.disablesAutomaticKeyboardDismissal = false
        
        searchController.searchBar.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: Screen.width, height: tableView.tableHeaderView!.frame.size.height))
        
        definesPresentationContext = true
        
        // 取消按钮文字
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "取消"
        
        tableView.tableHeaderView?.addSubview(searchController.searchBar)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            switch identifier {
            case ReuseIdentifier.Pop:
                
                if let tvc = segue.destination as? AddressBookAddPopViewController {
                    
                    if let pop = tvc.popoverPresentationController {
                        pop.delegate = self
                    }
                }
            default:
                break
            }
            
        }
    }
    

    fileprivate func fetchData() {
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.contact, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let models = AddressBookModel.models(dic: response)
            self.indexArray = BMChineseSort.index(with: models, key: "name") as? [NSArray]
            self.letterArray = BMChineseSort.letterSortArray(models) as? [String]
            
        }
        
    }
    
    fileprivate var params: [String: Any] {
        let loginModel = LoginModel.load()!
        return ["user_id": loginModel.user_id,
                "enterprise_id": loginModel.enterprise_id]
    }
    
    
}
// MARK: - UISearchControllerDelegate, UISearchResultsUpdating
extension AddressBookViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        tableView.reloadData()
    }
    
}

// MARK: - UIPopoverPresentationControllerDelegate
extension AddressBookViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        
        return .none
    }
    
    
}

// MARK: - UITableView Delegate Datasource
extension AddressBookViewController {
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return searchController.isActive ? 1 : indexArray == nil ? 0 : indexArray!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let indexArray = indexArray {
            return indexArray[section].count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.AddressBook, for: indexPath)
        
        if let cell = cell as? AddressBookTableViewCell {
            cell.model = indexArray![indexPath.section][indexPath.row] as? AddressBookModel
        }
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       
        return letterArray
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return searchController.isActive ? nil : letterArray?[section]
    }
    
}
