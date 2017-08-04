//
//  MyFavoriteViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/4.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MyFavoriteViewController: BaseViewController
{

    @IBOutlet weak var header: UIView!
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var typeTableView: UITableView!
    @IBOutlet weak var tipView: UIView!
    @IBAction func all(_ sender: Any) {
        
        showTypeTableView()
    }
    @IBAction func hiddenType(_ sender: Any) {
    
        hiddenTypeTableView()
    }
    
    fileprivate var products: [MyFavoriteModel]?
    fileprivate var types: [MyFavoriteTypeModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()

        hiddenTypeTableView()
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        products = MyFavoriteModel.models()
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
        
        types = MyFavoriteTypeModel.models()
        DispatchQueue.main.async {
            
            self.typeTableView.reloadData()
        }
    }
    
    
    fileprivate enum ReuseIdentifier {
        static let ListType = "ListType"
        static let Product = "Product"
    }
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "收藏夹"
    }
}
// MARK: - UITableViewDelegate Datasource
extension MyFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch tableView {
        case mainTableView: return products == nil ? 0 : products!.count
        case typeTableView: return types == nil ? 0 : types!.count
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        switch tableView {
        case mainTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Product, for: indexPath)
            (cell as! MyFavoriteTableViewCell).model = products?[indexPath.row]
        case typeTableView:
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.ListType, for: indexPath)
            (cell as! MyFavoriteTypeTableViewCell).model = types?[indexPath.row]
        default: break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let sectionHeader = UIView()
        sectionHeader.backgroundColor = UIColor.groupTableViewBackground
        return sectionHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch tableView {
        case typeTableView:
            hiddenTypeTableView()
        default:
            break
        }
    }
}
// MARK: - FilePrivate
extension MyFavoriteViewController {
    
    // MARK: - Show Type List
    func showTypeTableView() {
        
        if self.tipView.frame.origin.y == self.header.bottom {
            return
        }
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            self.tipView.frame.origin.y = self.header.bottom

        }, completion: nil)
    }
    
    // MARK: - hidden Type List
    func hiddenTypeTableView() {
        
        UIView.animate(withDuration: 0.3, animations: { 
            
            self.tipView.frame.origin.y = self.mainTableView.bottom
        }, completion: nil)
    }
}
