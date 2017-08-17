//
//  EXNavigationController.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import Foundation

extension UINavigationController {
    
    func ecPushViewController(_ viewController: UIViewController, animated: Bool = true, isHidesBottomBarWhenPushed: Bool = true) {
        
        (self as? BaseNavigationController)?.isHidesBottomBarWhenPushed = isHidesBottomBarWhenPushed
        
        if Thread.isMainThread {
            
            pushViewController(viewController, animated: true)
            return
        }
        
        DispatchQueue.main.async {
            self.pushViewController(viewController, animated: true)
        }
    }

    func ecPopViewController(animated: Bool = true) {
        
        if Thread.isMainThread {
            popViewController(animated: true)
            return
        }
        
        DispatchQueue.main.async {
            self.popViewController(animated: true)
        }
    }
    
    func ecPopToRootViewController(animated: Bool = true) {
        
        if Thread.isMainThread {
            popToRootViewController(animated: animated)
            return
        }
        
        DispatchQueue.main.async {
            self.popToRootViewController(animated: animated)
        }
        
    }
    
    func ecPopToViewController(viewController: UIViewController, animated: Bool = true) {
        
        if Thread.isMainThread {
            popToViewController(viewController, animated: animated)
            return
        }
        
        DispatchQueue.main.async {
            self.popToViewController(viewController, animated: animated)
        }
        
    }
    
    func ecPresent(viewController vc: UIViewController) {
        
        if Thread.isMainThread {
            present(vc, animated: true, completion: nil)
            return
        }
        
        DispatchQueue.main.async {
        
            self.present(vc, animated: true, completion: nil)
        }
    }
}
