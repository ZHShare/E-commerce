//
//  MineDetailsDepartmentViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MineDetailsDepartmentViewController: BaseTableViewController
{

    var selected: ((MineDetailsDepartmentModel) -> Void)?
    var models: [MineDetailsDepartmentModel]?
    
    fileprivate enum ReuseIdentifier {
        static let Department = "Department"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        models = MineDetailsDepartmentModel.models()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    fileprivate func configTableView() {
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

}
// MARK: - UITableView delegate Datasource
extension MineDetailsDepartmentViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let models = models {
            return models.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Department, for: indexPath)
        (cell as! MineDetailsDepartmentTableViewCell).model = models?[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let selected = selected {
            let model = models![indexPath.row]
            selected(model)
            navigationController?.ecPopViewController()
        }
        
    }
}
