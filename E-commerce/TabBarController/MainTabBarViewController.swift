//
//  MainViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/18.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController
{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    
}
// MARK: - UITabBarControllerDelegate
extension MainTabBarViewController: UITabBarControllerDelegate
{
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        tabBarButtonClick(sender: getSelectedTabBarButton())
    }
    
}

// MARK: - 私有方法
fileprivate extension MainTabBarViewController
{
    
    enum UITabBarSubClass {
        static let SwappableImageView: AnyClass? = NSClassFromString("UITabBarSwappableImageView")
        static let Label: AnyClass? = NSClassFromString("UITabBarButtonLabel")
        static let Main: AnyClass? = NSClassFromString("UITabBarButton")
    }
    
    enum TransformKeyPath {
        static let Scale = "transform.scale"
    }
    
    // 获取当前选中的TabBarButton
    func getSelectedTabBarButton() -> UIControl? {
        
        let tabBarButtons = NSMutableArray()
        
        for tabBarButton in tabBar.subviews {
            
            if let className = UITabBarSubClass.Main {
                
                if tabBarButton.classForCoder == className {
                    tabBarButtons.add(tabBarButton)
                }
            }
        }
        
        return tabBarButtons[selectedIndex] as? UIControl
    }
    
    // 给选中的UIBarButton 上的 imageView 和 label 添加动画
    func tabBarButtonClick(sender: UIControl?) {
        
        guard let sender = sender else { return }
        
        for sub in sender.subviews {
            
            if let swappableImageViewClass = UITabBarSubClass.SwappableImageView {
                
                if sub.classForCoder == swappableImageViewClass {
                    
                    addAnimationForView(view: sub)
                }
            }
            
            if let labelClass = UITabBarSubClass.Label {
                
                if sub.classForCoder == labelClass {
                    
                    addAnimationForView(view: sub)
                }
            }
        }
    }
    
    func addAnimationForView(view: UIView) {
        
        let animation = CAKeyframeAnimation()
        animation.keyPath = TransformKeyPath.Scale
        animation.values = [1.0,1.1,0.9,1.0]
        animation.duration = 0.3
        animation.calculationMode = kCAAnimationCubic
        
        view.layer.add(animation, forKey: nil)
    }
}
