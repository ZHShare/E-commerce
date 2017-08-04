//
//  SettingViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SettingViewController: BaseTableViewController
{

   
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }
    
    @IBAction func exit() {
       
        LoginModel.remove()
        let tabbarController = ECStroryBoard.controller(type: MainTabBarViewController.self)
        UIApplication.shared.keyWindow?.rootViewController = tabbarController
    }

    fileprivate func configNavigationBar() {
        
        navigationItem.title = "设置"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0: didClickFeedBack()
        case 1: didClickAbout()
        default:
            break
        }
    }
    
    fileprivate func didClickFeedBack() {
        
        let feedBackViewController = ECStroryBoard.controller(type: FeedBackViewController.self)
        navigationController?.ecPushViewController(feedBackViewController)
    }
    
    fileprivate func didClickAbout() {
        
        let aboutViewController = ECStroryBoard.controller(type: AboutViewController.self)
        navigationController?.ecPushViewController(aboutViewController)
    }
}


