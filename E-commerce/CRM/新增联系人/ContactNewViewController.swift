//
//  ContactNewViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import EZSwiftExtensions
class ContactNewViewController: BaseTableViewController
{

    @IBAction func tapClickSex(_ sender: UITapGestureRecognizer) {
        clickSex()
    }
    

    @IBAction func tapClickBirthday(_ sender: UITapGestureRecognizer) {
        clickBirthday()
    }
    
    
    @IBAction func tapClickShip(_ sender: UITapGestureRecognizer) {
        clickShip()
    }
    
    @IBAction func tapClickClose(_ sender: UITapGestureRecognizer) {
        clickClose()
    }
    
    var cust_no: String?
    @IBOutlet weak var nameField: UITextField!
  
    @IBOutlet weak var displaySex: UILabel!
    
    @IBOutlet weak var companyField: UITextField!
    
    @IBOutlet weak var unitField: UITextField!
    
    @IBOutlet weak var dutyFIeld: UITextField!
    
    @IBOutlet weak var phoneField: UITextField!
    
    @IBOutlet weak var mobilePhoneField: UITextField!
    
    @IBOutlet weak var QQField: UITextField!
    
    @IBOutlet weak var weChatField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var displayBirthDay: UILabel!
    
    @IBOutlet weak var loveField: UITextField!
    
    @IBOutlet weak var remakeField: UITextField!
    
    @IBOutlet weak var displayShip: UILabel!
    
    @IBOutlet weak var displayClose: UILabel!
    
    fileprivate var close: String? {
        
        get {
            switch displayClose.text! {
            case "初相识": return "0"
            case "一般": return "1"
            case "朋友": return "2"
            default: return "3"
            }
        }
        
        set {
            displayClose.text = newValue
        }
    }
    
    fileprivate var ship: String? {
        
        get {
            switch displayShip.text! {
            case "决策人": return "1"
            default: return "2"
            }
        }
        
        set {
            
            displayShip.text = newValue
        }
    }
    
    fileprivate var sex: String? {
        
        get {
            switch displaySex.text! {
            case "请选择": return "0"
            case "女": return "2"
            default: return "1"
            }
        }
        
        set {
            
           displaySex.text = newValue
        }
    }
    
    fileprivate var birthday: String? {
        
        get {
        
            if displayBirthDay.text == "未选择" {
                return "00000000"
            }
            
            return Date(fromString: displayBirthDay.text!, format: "yyyy-MM-dd")?.toString(format: "yyyyMMdd")
        }
        
        set {
            
            displayBirthDay.text = Date(fromString: newValue!, format: "yyyyMMdd")?.toString(format: "yyyy-MM-dd")
        }
    }
    
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        
        if nameField.text!.length == 0 {
            return super.hudForWindowsWithMessage(msg: "请填写名字")
        }
        
        if mobilePhoneField.text!.length == 0 {
            return super.hudForWindowsWithMessage(msg: "请填写手机号码")
        }
        
        let alertController = UIAlertController(title: nil, message: "是否设为默认联系人?", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "是", style: UIAlertActionStyle.default, handler: { (act) in
            
            self.updateWithFlag(flag: "1")
        }))
        
        alertController.addAction(UIAlertAction(title: "否", style: UIAlertActionStyle.cancel, handler: { (act) in
            
            self.updateWithFlag(flag: "0")
        }))
        
        presentVC(alertController)
        
    }
    
    fileprivate func updateWithFlag(flag: String) {
        
        let params: [String: Any] = ["name": nameField.text ?? "",
                                     "sex": sex ?? "",
                                     "enterprise": companyField.text ?? "",
                                     "department": unitField.text ?? "",
                                     "duties": dutyFIeld.text ?? "",
                                     "phone": phoneField.text ?? "",
                                     "mobile": mobilePhoneField.text ?? "",
                                     "qq": QQField.text ?? "",
                                     "remark": remakeField.text ?? "",
                                     "role_relationship": ship ?? "",
                                     "relationship": close ?? "",
                                     "cust_no": cust_no ?? "",
                                     "wx_no": weChatField.text ?? "",
                                     "hobbies": loveField.text ?? "",
                                     "birthday": birthday ?? "00000000",
                                     "default_flag": flag]
        
        CRMNet.fetchDataWith(transCode: TransCode.CRM.contactNew, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            super.hudForWindowsWithMessage(msg: "新增成功")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1, execute: { 
                
                if let root = self.navigationController?.viewControllers[1] as? MyCustomerTableViewController {
                    self.navigationController?.ecPopToViewController(viewController: root)
                    root.fetchData()
                }
                
            })
        }
        
        
    }

    @IBAction func tapPress(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
}
// MARK: - UITableView delegate datasource
extension ContactNewViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
//        switch indexPath {
//        case IndexPath(row: 1, section: 0): clickSex()
//        case IndexPath(row: 10, section: 0): clickBirthday()
//        case IndexPath(row: 0, section: 1): clickShip()
//        case IndexPath(row: 1, section: 1): clickClose()
//        default: break
//        }
    }
}
// MARK: - FilePrivate
fileprivate extension ContactNewViewController {
    
    // MARK: click sex
    func clickSex() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let man = "男"
        alertController.addAction(UIAlertAction(title: man, style: UIAlertActionStyle.default, handler: { (act) in
            self.sex = man
        }))
        
        let women = "女"
        alertController.addAction(UIAlertAction(title: women, style: UIAlertActionStyle.default, handler: { (act) in
            self.sex = women
        }))
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        
        presentVC(alertController)
    }
    
    // MARK: click birtyday
    func clickBirthday() {
        
        let picker = ECStroryBoard.view(type: MiniDetailsDatePicker.self)
        UIApplication.shared.keyWindow?.addSubview(picker)
        picker.dateChose = { (date) in
            self.birthday = date
        }
    }
    
    // MARK: click ship
    func clickShip() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let isDecisionPerson = "决策人"
        alertController.addAction(UIAlertAction(title: isDecisionPerson, style: UIAlertActionStyle.default, handler: { (act) in
            self.ship = isDecisionPerson
        }))
        
        let isNotDecisionPerson = "非决策人"
        alertController.addAction(UIAlertAction(title: isNotDecisionPerson, style: UIAlertActionStyle.default, handler: { (act) in
            self.ship = isNotDecisionPerson
        }))
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        
        presentVC(alertController)
    }
    
    // MARK: click close
    func clickClose() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let start = "初相识"
        alertController.addAction(UIAlertAction(title: start, style: UIAlertActionStyle.default, handler: { (act) in
            self.close = start
        }))
        
        let normal = "一般"
        alertController.addAction(UIAlertAction(title: normal, style: UIAlertActionStyle.default, handler: { (act) in
            self.close = normal
        }))
       
        let firend = "朋友"
        alertController.addAction(UIAlertAction(title: firend, style: UIAlertActionStyle.default, handler: { (act) in
            self.close = firend
        }))
        
        
        let goodFirend = "好友"
        alertController.addAction(UIAlertAction(title: goodFirend, style: UIAlertActionStyle.default, handler: { (act) in
            self.close = goodFirend
        }))
        
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        
        presentVC(alertController)
    }
    
}
