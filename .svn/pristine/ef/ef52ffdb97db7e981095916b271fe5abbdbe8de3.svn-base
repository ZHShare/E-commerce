//
//  SureShoppingViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/1.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SureShoppingViewController: BaseTableViewController
{
    fileprivate let bar: SureShoppingBar = UIView.loadFromNibNamed(nibNamed: "SureShoppingBar") as! SureShoppingBar
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        updateBarFrame()
    }
    
    fileprivate enum ReuseIdentifier {
        static let Address = "Address"
        static let Product = "Product"
        static let Normal = "Normal"
        static let Field = "Field"
    }
    
    fileprivate enum SectionRow {
        static let Address = 1
        static let Normal = 3
        static let Zero = 0
    }
    
    fileprivate func config() {
        
        tableView.addSubview(bar)
        tableView.bringSubview(toFront: bar)
        
        navigationItem.title = "确定购买"
    }
    
    fileprivate func updateBarFrame() {
        
        bar.frame.origin = CGPoint(x: 0, y: tableView.contentOffset.y + tableView.frame.size.height - 44)
    }
    
}


// MARK: - UITableViewDelegate, UITableViewDataSource
extension SureShoppingViewController {
    
   
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return SectionRow.Address
        case 1: return 2
        case 2: return SectionRow.Normal
        default: return SectionRow.Zero
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Address, for: indexPath)
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Product, for: indexPath)
        case 2:
            if indexPath.row == 2 {
                cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Field, for: indexPath)
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Normal, for: indexPath)
            }
        default: cell = UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
   
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.001
    }
    
}
// MARK: - UIScrollViewDelegate
extension SureShoppingViewController {
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateBarFrame()
    }
}
