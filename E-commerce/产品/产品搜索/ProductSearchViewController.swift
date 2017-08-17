//
//  ProductSearchViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/15.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductSearchViewController: BaseViewController
{
    fileprivate let userDefault = UserDefaults.standard

    @IBOutlet weak var searchField: UITextField!
    @IBAction func clear() {
        
        result = nil
        userDefault.removeObject(forKey: SearchHistoryKey.History)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate var result: [String]?
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func search() {
        
        searchField.resignFirstResponder()
        if searchField.text!.length == 0 { return }
        if let cacheResult = userDefault.array(forKey: SearchHistoryKey.History) as? [String] {
            
            result = cacheResult
            if result!.contains(searchField.text!) == false {
                
                result?.append(searchField.text!)
                userDefault.set(result, forKey: SearchHistoryKey.History)
            }
        }
        else {
            
            result = [searchField.text!]
            userDefault.set(result, forKey: SearchHistoryKey.History)
        }
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        
        listForString(string: searchField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }

    fileprivate func loadData() {
        
        guard let cacheResult = userDefault.array(forKey: SearchHistoryKey.History) as? [String] else{
            
            return
        }
        
        result = cacheResult
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate enum ReuseIdentifier {
        static let History = "History"
    }
    
    fileprivate func listForString(string: String?) {
        
        if string == nil || string!.length == 0 {
            return
        }
        
        let listViewController = ECStroryBoard.controller(type: ProductListViewController.self)
        listViewController.searchText = string
        navigationController?.ecPushViewController(listViewController)
    }
}
extension ProductSearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result == nil ? 0 : result!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.History, for: indexPath) as! ProductSearchTableViewCell
        
        cell.displayTitle.text = result?[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        listForString(string: result?[indexPath.row])
    }
}
