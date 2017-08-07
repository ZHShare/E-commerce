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
    fileprivate var keysValues = [String: NSMutableArray]()
    fileprivate var searchResults = [AddressBookModel]()

    fileprivate enum ReuseIdentifier {
        static let AddressBook = "Address Book"
        static let Pop = "Add"
    }
  
    fileprivate var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configSearchController()
//        fetchData()
        demoData()
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
        searchController.dimsBackgroundDuringPresentation = false
        
        
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
    
    fileprivate func demoData() {
        
        let models = AddressBookModel.models(dic: AddressBookModel.response)
        
        for model in models! {
            
            if let value = keysValues[model.firstLetter] {
                value.add(model)
            }
            else {
                keysValues[model.firstLetter] = [model]
            }
        }
        
        var letters = [String]()
        for key in keysValues {
            
            letters.append(key.key)
        }
        letterArray = letters
    
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
  
    
    fileprivate func fetchData() {
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.contact, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let models = AddressBookModel.models(dic: response)
            
        }
        
    }
    
    fileprivate var params: [String: Any] {
        let loginModel = LoginModel.load()!
        return ["user_id": loginModel.user_id,
                "enterprise_id": loginModel.enterprise_id]
    }
    
    
}
extension AddressBookModel {
    
    var firstLetter: String {
        
        let pinyin = name.transformToPinYin()
        let capitalizedString = pinyin.capitalizedFirst()
        let index = capitalizedString.index(capitalizedString.startIndex, offsetBy: 1)
        return capitalizedString.substring(to: index)
    }
}
extension String{
    func transformToPinYin()->String{
        let mutableString = NSMutableString(string: self)
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        return string.replacingOccurrences(of: " ", with: "")
    }
}

// MARK: - UISearchControllerDelegate, UISearchResultsUpdating
extension AddressBookViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        searchResults.removeAll()
        
        let searchText = searchController.searchBar.text!
        for values in keysValues.values {
            
            for value in values {
                
                if let value = value as? AddressBookModel {
                    
                    if value.name.contains(searchText) {
                        searchResults.append(value)
                    }
                }
            }
        }
        
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
        return searchController.isActive ? 1 : letterArray == nil ? 0 : letterArray!.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            return searchResults.count
        }
        
        
        if let lettersArray = letterArray {
            return keysValues[lettersArray[section]]!.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.AddressBook, for: indexPath)
        
        if let cell = cell as? AddressBookTableViewCell {
            
            if searchController.isActive {
                cell.model = searchResults[indexPath.row]
                return cell
            }
            
            cell.model = keysValues[letterArray![indexPath.section]]?[indexPath.row] as? AddressBookModel
        }
        
        return cell
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
       
        return letterArray
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return searchController.isActive ? nil : letterArray?[section]
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailsViewController = ECStroryBoard.controller(type: AddressBookDetailsViewController.self)
        navigationController?.ecPushViewController(detailsViewController)
    }
}
