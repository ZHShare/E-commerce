//
//  AboutViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class AboutViewController: BaseViewController {

    @IBOutlet var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
    }

    fileprivate func configNavigationBar() {
        navigationItem.title = "关于我们"
    }
    
}
// MARK: - UIWebView delegate
extension AboutViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("开始加载")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        print("加载完成")
    }
    
}
