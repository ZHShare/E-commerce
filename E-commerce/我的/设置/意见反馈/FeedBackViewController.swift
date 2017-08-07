//
//  FeedBackViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class FeedBackViewController: BaseTableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configNavigationBar()
        
    }
    @IBOutlet weak var contentTextView: UITextView! { didSet { configTextView() } }
    
    @IBOutlet weak var placeHolder: UILabel!
    
    fileprivate let maxLength = 200
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "意见反馈"
    }
    
    fileprivate func configTextView() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(valueChanged), name: NSNotification.Name.UITextViewTextDidChange, object: nil)
    }
    
    @objc fileprivate func valueChanged() {
        
        if contentTextView.text.length == 0 {
            placeHolder.isHidden = false
        }
        else {
            placeHolder.isHidden = true
        }
        
        let lang = contentTextView.textInputMode!.primaryLanguage
        if lang == "zh-Hans" {
            
            let range = contentTextView.markedTextRange
            
            if range == nil {
                
                if contentTextView.text!.length >= maxLength {
                    contentTextView.text = (contentTextView.text! as NSString).substring(to: maxLength)
                }
                
            }
            
        }
        else {
            
            if contentTextView.text!.length >= maxLength {
                contentTextView.text = (contentTextView.text! as NSString).substring(to: maxLength)
            }
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    

    @IBAction func submit() {
        
        let content = contentTextView.text!
        var params = ["content": content]
        if let logmodel = LoginModel.load() {
            
            params["user_id"] = logmodel.user_id
            params["user_mobile"] = logmodel.user_mobile
        }
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.feedBack, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let alert = UIAlertController(title: nil, message: "已收到您的反馈", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "确定", style: UIAlertActionStyle.cancel, handler: { (cancel) in
                
                self.navigationController?.ecPopViewController()
            }))
            
            self.navigationController?.ecPresent(viewController: alert)
        }
        
    }
}
