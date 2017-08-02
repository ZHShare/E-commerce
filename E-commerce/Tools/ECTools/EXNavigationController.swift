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
        pushViewController(viewController, animated: true)
    }

    func ecPopViewController(animated: Bool = true) {
        
        popViewController(animated: true)
    }
    
}
