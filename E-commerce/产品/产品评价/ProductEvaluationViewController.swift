//
//  ProductEvaluationViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/31.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import MJRefresh

class ProductEvaluationViewController: BaseTableViewController
{

    fileprivate var datas: [ProductEvalutaionModel]?
    var productID: String = ""
    
    fileprivate let mjFooter = MJRefreshAutoNormalFooter()
    fileprivate let mjHeader = MJRefreshNormalHeader()
    fileprivate var pageNumber: Int = 0 {
        didSet { fetchData() }
    }
    fileprivate enum ReuseIdentifier {
        static let evaluation = "Product Evaluation"
    }
    fileprivate var status = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        
    }
    
    fileprivate func fetchData() {
        
        let params:[ String: Any] = ["product_id": productID,
                                     "status": status,
                                     "page_num": String(pageNumber)]
        HomeNet.fetchDataWith(transCode: TransCode.Home.evaluation, params: params) { (response, isLoadFaild, errorMsg) in
            
            self.endRefreshing()
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let datas = ProductEvalutaionModel.models(withResponse: response)
            if self.pageNumber == 1 {
                self.datas = datas
            }
            else if datas.count > 0 {
                
                var oldDatas = self.datas!
                oldDatas.append(contentsOf: datas)
                self.datas = oldDatas
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        
    }
    
    fileprivate func config() {
        
        navigationItem.title = "评价"
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.mj_header = mjHeader
        tableView.mj_footer = mjFooter
        
        mjFooter.refreshingBlock = {
            
            self.pageNumber += 1
        }
        
        mjHeader.refreshingBlock = {
            
            self.pageNumber = 1
        }
        
        let tableHeader = tableView.tableHeaderView as? ProductEvaluationHeader
        tableHeader?.delegate = self
        
        mjHeader.beginRefreshing()
    }
    
    fileprivate func endRefreshing() {
        
        if Thread.isMainThread {
            mjHeader.endRefreshing()
            mjFooter.endRefreshing()
        }
        
        else {
            
            DispatchQueue.main.async {
                self.mjHeader.endRefreshing()
                self.mjFooter.endRefreshing()
            }
            
        }
    }
}
// MARK: - ProductEvaluationHeaderDelegate
extension ProductEvaluationViewController: ProductEvaluationHeaderDelegate {
    
    func didClick(sender: UIButton) {
        
        status = "\(sender.tag)"
        mjHeader.beginRefreshing()
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
