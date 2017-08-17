//
//  CustomerNewViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class CustomerNewViewController: BaseTableViewController
{

    @IBAction func next() {
        
        if nameField.text!.length == 0 {
            return super.hudForWindowsWithMessage(msg: "请输入客户名称")
        }
        
        if customerAllField.text!.length == 0 {
            return super.hudForWindowsWithMessage(msg: "请输入客户全称")
        }
        
        if displayAddressLabel.text!.length == 0 {
            return super.hudForWindowsWithMessage(msg: "请选择地址")
        }
        
        params["cust_short"] = nameField.text
        params["cust_name"] = customerAllField.text
        params["cust_url"] = webSitField.text

        
        CRMNet.fetchDataWith(transCode: TransCode.CRM.customerNew, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            let custNumber = (response["data"] as? [String: Any])?["cust_no"] as? String
            let contactNewController = ECStroryBoard.controller(type: ContactNewViewController.self)
            contactNewController.cust_no = custNumber
            self.navigationController?.ecPushViewController(contactNewController)
        }
    }
    @IBOutlet weak var displayLv: UILabel!
    @IBOutlet weak var displayIntro: UILabel!
    @IBOutlet weak var webSitField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var customerAllField: UITextField!
    @IBOutlet weak var displayAddressLabel: UILabel!
    fileprivate var params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                             "cust_type": "0"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    var address: MapAddress {
        get { return MapAddress(address: "", latitude: "", longitude: "") }
        set {
            displayAddressLabel.text = newValue.address
            params["cust_address"] = newValue.address
            params["locations_lat"] = newValue.latitude
            params["locations_lng"] = newValue.longitude
        }
    }
    
    var intro: String {
        get { return displayIntro.text ?? "" }
        set {
            displayIntro.text = newValue
        }
    }
    
    var level: String {
        get { return displayLv.text ?? "" }
        set {
            displayLv.text = newValue
            params["cust_type"] = newValue.type
        }
    }
    
}
fileprivate extension String {
    
    var type: String {
        var t = ""
        switch self {
        case "一般客户": t = "0"
        case "重要客户": t = "1"
        case "重点客户": t = "2"
        case "非常重要客户": t = "3"

        default:
            break
        }
        return t
    }
}

// MARK: UITableView Delegate
extension CustomerNewViewController {
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 2: didClickAddress()
        case 4: didClickIntro()
        case 5: didClickLevel()
        default:
            break
        }
    }
}
// MARK: - FIlePrivate funcs
fileprivate extension CustomerNewViewController {
    
    // MARK: - did click intro
    func didClickIntro() {
        
        let introController = ECStroryBoard.controller(type: FeedBackViewController.self)
        introController.type = .Intro
        introController.content = { content in
            self.intro = content
        }
        navigationController?.ecPushViewController(introController)
    }
    
    // MARK: - did click customer address
    func didClickAddress() {
        
        let addressViewController = ECStroryBoard.controller(type: MapSelectedAddressViewController.self)
        addressViewController.address = { (address) in
            self.address = address
        }
        navigationController?.ecPushViewController(addressViewController)
    }
    
    // MARK: - did click level
    func didClickLevel() {
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let normal = "一般客户"
        alert.addAction(UIAlertAction(title: normal, style: UIAlertActionStyle.default, handler: { (action) in
            
            self.level = normal
        }))
        
        let important = "重要客户"
        alert.addAction(UIAlertAction(title: important, style: UIAlertActionStyle.default, handler: { (action) in
            
            self.level = important
        }))
        
        let importPoint = "重点客户"
        alert.addAction(UIAlertAction(title: importPoint, style: UIAlertActionStyle.default, handler: { (action) in
            
            self.level = importPoint
        }))
        
        let veryImportant = "非常重要客户"
        alert.addAction(UIAlertAction(title: veryImportant, style: UIAlertActionStyle.default, handler: { (action) in
            
            self.level = veryImportant
        }))
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        presentVC(alert)
    }
}
