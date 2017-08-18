//
//  LogNavViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController {

    var isHidesBottomBarWhenPushed: Bool = true
    
    internal override class func initialize() {
        super.initialize()
        
        /// 设置导航栏标题
        let navBar = UINavigationBar.appearance()
        navBar.tintColor = UIColor.white
        navBar.isTranslucent = false
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.black]
    }
    
    /**
     # 统一所有控制器导航栏左上角的返回按钮
     # 让所有push进来的控制器，它的导航栏左上角的内容都一样
     # 能拦截所有的push操作
     - parameter viewController: 需要压栈的控制器
     - parameter animated:       是否动画
     */
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        /// 这时push进来的控制器viewController，不是第一个子控制器（不是根控制器）
        if viewControllers.count > 0 {
            // push 后隐藏 tabbar
            viewController.hidesBottomBarWhenPushed = isHidesBottomBarWhenPushed
            
            if viewController.isKind(of: ShoppingResultsViewController.classForCoder()) {
                
                let closeItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.stop, target: self, action: #selector(close(_:)))
                closeItem.tintColor = .black
                viewController.navigationItem.leftBarButtonItem = closeItem
            }
                
            else {
                
                viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "log_reg_left"), style: .plain, target: self, action: #selector(navigationBackClick))
                viewController.navigationItem.leftBarButtonItem?.tintColor = UIColor.black
                
            }
        }
        super.pushViewController(viewController, animated: true)
    }
    /// 返回按钮
    func navigationBackClick() {

        _ = popViewController(animated: true)
    }

    @objc fileprivate func close(_ sender: UIBarButtonItem) {
        
        for viewController in viewControllers {
            
            if let shoppingCarViewController = viewController as? ShoppingCarViewController {
                ecPopToViewController(viewController: shoppingCarViewController)
                shoppingCarViewController.fetchData()
                return
            }
            else if let detailsViewController = viewController as? MedicalProductDetailsViewController {
                ecPopToViewController(viewController: detailsViewController)
                detailsViewController.fetchData()
                return
            }
        }
        
    }

}
