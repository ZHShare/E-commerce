//
//  AddressListViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AddressListViewController: BaseTableViewController
{

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    fileprivate enum ReuserIdentifier {
        static let Address = "Address"
    }
}
// MARK: - UISearchControllerDelegate, UISearchResultsUpdating
extension AddressListViewController: UISearchControllerDelegate, UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        print(searchController.searchBar.text)
        
    }
    
    
}
// MARK: - UITableView Delegate Datasource
extension AddressListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuserIdentifier.Address, for: indexPath)
        
        return cell
    }
}
