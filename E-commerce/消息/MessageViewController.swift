//
//  MessageViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MessageViewController: UITableViewController {

    fileprivate enum ReuseIdentifier {
        static let list = "List Cell"
    }
    
    var models: [MessageModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    @IBAction func refreshing(_ sender: UIRefreshControl) {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) { 
            sender.endRefreshing()
        }
    }
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        if LoginStatus.isLogined { return }
        enterLogin()
    }
}

// MARK: - FIlePrivate
fileprivate extension MessageViewController {
    
    
    func fetchData() {
        
        models = MessageModel.models()
        DispatchQueue.main.async {
            self.tableView?.reloadData()
        }
    }
    
    func enterLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let logNav = storyboard.instantiateViewController(withIdentifier: "BaseNavigationController") as? BaseNavigationController {
            present(logNav, animated: true, completion: nil)
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension MessageViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let models = models {
            return models.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.list) as? MessageTableViewCell {
            
            cell.model = models![indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if LoginStatus.isLogined {
            
            print("跳转")
            return
        }

        enterLogin()
    }
}
