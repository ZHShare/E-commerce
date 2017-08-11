//
//  MedicalProductDetailsImagesCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import MBProgressHUD

protocol MedicalProductDetailsImagesCellDelegate {
    
    func imagesDidLoad(withHeight: CGFloat)
    func paramsDidLoad(withHeight: CGFloat)
    func intallsDidLoad(withHeight: CGFloat)
}

class MedicalProductDetailsImagesCell: UITableViewCell
{
    fileprivate let imageH5 = "/h5/introduction.htm?product_id="
    
    var delegate: MedicalProductDetailsImagesCellDelegate?
    @IBOutlet weak var webView: UIWebView! {
        didSet { configWebView() }
    }
   
    var product_id: String? {
        didSet { loadWebView() }
    }
    
    fileprivate func configWebView() {
        webView.scrollView.isScrollEnabled = false
    }
    
    
    fileprivate func loadWebView() {
        
        if product_id == nil {
            return
        }
        
        let urlString = "\(host):\(8080)/\(objectAddress)\(imageH5)\(product_id!)"
        webView.loadRequest(URLRequest.init(url: URL(string: urlString)!))
        
    }
    
}
// MAKR: - UIWebViewDelegate
extension MedicalProductDetailsImagesCell: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
       
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        let height = webView.scrollView.contentSize.height
        delegate?.imagesDidLoad(withHeight: height)
        
    }
    
}


class MedicalProductDetailsPramsCell: UITableViewCell
{
    fileprivate let paramsH5 = "/h5/parameter.htm?product_id="
    
    var delegate: MedicalProductDetailsImagesCellDelegate?
    @IBOutlet weak var webView: UIWebView! {
        didSet { configWebView() }
    }
    
    var product_id: String? {
        didSet { loadWebView() }
    }
    
    fileprivate func configWebView() {
        webView.scrollView.isScrollEnabled = false
    }
    
    
    fileprivate func loadWebView() {
        
        if product_id == nil {
            return
        }
        
        let urlString = "\(host):\(8080)/\(objectAddress)\(paramsH5)\(product_id!)"
        webView.loadRequest(URLRequest.init(url: URL(string: urlString)!))
        
    }
    
}
// MAKR: - UIWebViewDelegate
extension MedicalProductDetailsPramsCell: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        let height = webView.scrollView.contentSize.height
        delegate?.paramsDidLoad(withHeight: height)
        
    }
    
}

class MedicalProductDetailsInstallCell: UITableViewCell
{
    fileprivate let setupH5 = "/h5/install.htm?product_id="
    
    var delegate: MedicalProductDetailsImagesCellDelegate?
    @IBOutlet weak var webView: UIWebView! {
        didSet { configWebView() }
    }
    
    var product_id: String? {
        didSet { loadWebView() }
    }
    
    fileprivate func configWebView() {
        webView.scrollView.isScrollEnabled = false
    }
    
    
    fileprivate func loadWebView() {
        
        if product_id == nil {
            return
        }
        
        let urlString = "\(host):\(8080)/\(objectAddress)\(setupH5)\(product_id!)"
        webView.loadRequest(URLRequest.init(url: URL(string: urlString)!))
        
    }
    
}
// MAKR: - UIWebViewDelegate
extension MedicalProductDetailsInstallCell: UIWebViewDelegate {
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        
        let height = webView.scrollView.contentSize.height
        delegate?.intallsDidLoad(withHeight: height)
        
    }
    
}
