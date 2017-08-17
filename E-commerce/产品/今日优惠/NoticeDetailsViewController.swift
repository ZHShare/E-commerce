//
//  NoticeDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/17.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class NoticeDetailsViewController: BaseViewController
{
    fileprivate let webURL = "/h5/notice.htm?notice_id="
    
    var notice_id: String?
    @IBOutlet weak var webView: UIWebView! {
        didSet { loadWebView() }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    fileprivate func loadWebView() {
        
        if notice_id == nil {
            return
        }
        
        let urlString = "\(host):\(port)/\(objectAddress)\(webURL)\(notice_id!)"
        webView.loadRequest(URLRequest.init(url: URL(string: urlString)!))
        
    }

}

// MARK: UIWebViewDelegate
extension NoticeDetailsViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        
    }
}
