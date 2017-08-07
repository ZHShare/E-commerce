//
//  AddressBookAddPopViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/7.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AddressBookAddPopViewController: BaseTableViewController
{
    fileprivate enum ReuseIdentifier {
        static let Pop = "Pop"
    }
    
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
    }
    
    override var preferredContentSize: CGSize {
        get {
            
            if tableView != nil && presentingViewController != nil {
                var size = tableView.sizeThatFits(presentingViewController!.view.bounds.size)
                size.width = 100
                return size
            }
            
            return super.preferredContentSize
        }
        set { super.preferredContentSize = newValue }
    }
    
    
}
// MARK: - UITableView Delegate Datasource
extension AddressBookAddPopViewController {
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Pop, for: indexPath)
        if let cell = cell as? AddressBookAddPopTableViewCell {
            cell.displayTitle.text = "添加"
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
