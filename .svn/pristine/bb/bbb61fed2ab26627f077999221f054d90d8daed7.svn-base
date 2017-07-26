//
//  GuideCollectionViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/18.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class GuideViewController: UIViewController {
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            
            scrollView.scrollsToTop = false
            scrollView.contentOffset = CGPoint.zero
        }
    }
    
    let numOfPages = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = self.view.bounds
        
        // 将 scrollView 的 contentSize 设为屏幕宽度的3倍(根据实际情况改变)
        scrollView.contentSize = CGSize(width: frame.size.width * CGFloat(numOfPages), height: frame.size.height)
        
        scrollView.delegate = self
        
        for index in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "GuideImage\(index)"))
            imageView.frame = CGRect(x: frame.size.width * CGFloat(index), y: 0, width: frame.size.width, height: frame.size.height)
            scrollView.addSubview(imageView)
        }
                
        // 隐藏开始按钮
        startButton.alpha = 0.0
    }
    
    // 隐藏状态栏
    @IBAction func mainPage(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let mainTabbarController = storyboard.instantiateViewController(withIdentifier: "MainTabBarViewController") as? MainTabBarViewController {
            UIApplication.shared.keyWindow?.rootViewController = mainTabbarController
        }}
    
}

// MARK: - UIScrollViewDelegate
extension GuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 随着滑动改变pageControl的状态
        let currentNumber = Int(offset.x / view.bounds.width)
        
        // 因为currentPage是从0开始，所以numOfPages减1
        if currentNumber == numOfPages - 1 {
            UIView.animate(withDuration: 0.5) {
                self.startButton.alpha = 1.0
            }
        } else {
            UIView.animate(withDuration: 0.2) {
                self.startButton.alpha = 0.0
            }
        }
    }
}
