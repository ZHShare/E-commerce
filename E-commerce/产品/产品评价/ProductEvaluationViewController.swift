//
//  ProductEvaluationViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/31.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductEvaluationViewController: BaseTableViewController
{

    var datas: [ProductEvalutaionModel]?
    
    fileprivate enum ReuseIdentifier {
        static let evaluation = "Product Evaluation"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        datas = ProductEvalutaionModel.models()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func config() {
        
        navigationItem.title = "评价"
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let tableHeader = tableView.tableHeaderView as? ProductEvaluationHeader
        tableHeader?.delegate = self
    }
}
// MARK: - ProductEvaluationHeaderDelegate
extension ProductEvaluationViewController: ProductEvaluationHeaderDelegate {
    
    func didClick(sender: UIButton) {
        print(sender.currentTitle!)
    }
}

// MARK: - UITable View Delegate Datesource
extension ProductEvaluationViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return datas == nil ? 0 : datas!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.evaluation, for: indexPath)
        
        if let cell = cell as? ProductEvaluationTableViewCell {
           
            cell.model = datas?[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
}
