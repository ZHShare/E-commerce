//
//  ContactNewViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ContactNewViewController: BaseTableViewController
{

  
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        self.navigationController?.popToViewController((navigationController?.viewControllers[1])!, animated: true)
    }

}
// MARK: - UITableView delegate datasource
extension ContactNewViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
