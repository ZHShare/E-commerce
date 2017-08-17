//
//  MineDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import MWPhotoBrowser
import SDWebImage

class MineDetailsViewController: BaseTableViewController
{

    fileprivate enum ReuseIdentifier {
        static let Header = "Header Image"
        static let Normal = "Normal"
    }
    
    fileprivate var titles: [[MineDetailsTitleModel]]?
    
    fileprivate var department: MineDetailsDepartmentModel? {
        didSet {
            
            if Thread.isMainThread {
                updateDepartment()
            }
            else {
                DispatchQueue.main.async {
                    self.updateDepartment()
                }
            }
            
           
        }
    }
    
    fileprivate var name: String = "" {
        didSet {
            
            if Thread.isMainThread {
                updateName()
            }
            else {
                DispatchQueue.main.async {
                    self.updateName()
                }
            }
        }
    }
    
    fileprivate var phone: String = "" {
        didSet {
            
            if Thread.isMainThread {
                updatePhone()
            }
            else {
                DispatchQueue.main.async {
                    self.updatePhone()
                }
            }
          }
    }
    
    fileprivate var enterprise: String = "" {
        didSet {
            
            if Thread.isMainThread {
                updateEnterprise()
            }
            else {
                DispatchQueue.main.async {
                    self.updateEnterprise()
                }
            }
        }
    }
    
    fileprivate var image: UIImage = UIImage() {
        didSet {
            
            if Thread.isMainThread {
                updateHeaderImage()
            }
            else {
                DispatchQueue.main.async {
                    self.updateHeaderImage()
                }
            }
        }
    }
    fileprivate var sex: String = "" {
        didSet {
            
            if Thread.isMainThread {
                updateSex()
            }
            else {
                DispatchQueue.main.async {
                    self.updateSex()
                }
            }
        }
    }
    fileprivate var birthday: String = "" {
        didSet {
            
            if Thread.isMainThread {
                updateBirthDay()
            }
            else {
                DispatchQueue.main.async {
                    self.updateBirthDay()
                }
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configTitle()
        configNavigationBar()
        updateUI()
    }

    fileprivate func updateUI() {
        
        if let loginModel = LoginModel.load() {
            
            name = loginModel.user_name
            phone = loginModel.user_mobile
            sex = loginModel.stringSex
            birthday = loginModel.user_birthday
            enterprise = loginModel.enterprise_name
            department = MineDetailsDepartmentModel(department_name: loginModel.department_name, department_id: "", superior_department_id: "")
            
            SDWebImageManager.shared().downloadImage(with: URL(string: loginModel.faceUrl), options: SDWebImageOptions(rawValue: 0), progress: { (_, _) in
                
            }, completed: { (img, error, type, flag, url) in
                
                if let img = img {
                    self.image = img
                }
            })
        }
    }
    
    fileprivate func configNavigationBar() {
        
        navigationItem.title = "我的资料"
    }
    
    fileprivate func configTableView() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    fileprivate func configTitle() {
        
        titles = MineDetailsTitleModel.models()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}
// MARK - UITableViewDelegate , Datasource
extension MineDetailsViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if let titles = titles {
            return titles.count
        }
        
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return titles![section].count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: UITableViewCell!
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Header, for: indexPath)
            (cell as? MineDetailsHeaderTableViewCell)?.headerImageView.image = image
        }
        else {
            cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.Normal, for: indexPath)
            (cell as? MineDetailsNormalTableViewCell)?.title = titles?[indexPath.section][indexPath.row]
            switch indexPath.section {
            case 0:
                switch indexPath.row {
                case 1: (cell as? MineDetailsNormalTableViewCell)?.displaySubTitle.text = sex
                case 2: (cell as? MineDetailsNormalTableViewCell)?.displaySubTitle.text = birthday
                default: break
                }
            case 1:
                switch indexPath.row {
                case 0: (cell as? MineDetailsNormalTableViewCell)?.displaySubTitle.text = name
                case 1: (cell as? MineDetailsNormalTableViewCell)?.accessoryView = UIView(frame: CGRect(x: 0, y: 0, w: 20, h: 20))
                    (cell as? MineDetailsNormalTableViewCell)?.displaySubTitle.text = phone
                case 2: (cell as? MineDetailsNormalTableViewCell)?.accessoryView = UIView(frame: CGRect(x: 0, y: 0, w: 20, h: 20))

                    (cell as? MineDetailsNormalTableViewCell)?.displaySubTitle.text = enterprise
                case 3:
                    (cell as? MineDetailsNormalTableViewCell)?.displaySubTitle.text = department?.department_name
                    break
                default: break
                }
            default: break
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            let infoLabel = UILabel(frame: CGRect(origin: CGPoint.init(x: 10, y: 0), size: CGSize.zero))
            infoLabel.sizeToFit()
            infoLabel.text = "   企业信息"
            infoLabel.textColor = UIColor.blue
            infoLabel.backgroundColor = UIColor.clear
            return infoLabel
        }
        
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.section {
        case 0:
            switch indexPath.row {
            case 0: didClickHeader()
            case 1: didClickSex()
            case 2: didClickBirthDay()
            default:
                break
            }
        case 1:
            switch indexPath.row {
            case 0: didClickName()
            case 3: didClickDepartment()
            default:
                break
            }
        default:
            break
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0001
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 {
            return 40
        }
        return 0.001
    }
    
}
// MARK: - Fileprivate
fileprivate extension MineDetailsViewController {
    
    // MARK: - click department 
    func didClickDepartment() {
        
        let departmentController = ECStroryBoard.controller(type: MineDetailsDepartmentViewController.self)
        navigationController?.ecPushViewController(departmentController)
        departmentController.selected = { (model) in
            LoginModel.update(value: model.department_name, key: "department_name")
            self.department = model
        }
    }
    
    // MAKR: - click name
    func didClickName() {
        
        let changeNameController = ECStroryBoard.controller(type: MineDetailsChangeViewController.self)
        changeNameController.name = name
        navigationController?.ecPushViewController(changeNameController)
        changeNameController.done = { (name) in
            LoginModel.update(value: name, key: "user_name")
            self.name = name
        }
    }
    
    // MARK: - click header
    func didClickHeader() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "拍照", style: UIAlertActionStyle.default, handler: { (alert) in
            self.openPhoto(type: .camera)
        }))
        alertController.addAction(UIAlertAction(title: "相册", style: UIAlertActionStyle.default, handler: { (alert) in
            self.openPhoto(type: .photoLibrary)
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - click sex
    func didClickSex() {
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.addAction(UIAlertAction(title: "男", style: UIAlertActionStyle.default, handler: { (alert) in
            self.changeSex(sex: "男")
        }))
        alertController.addAction(UIAlertAction(title: "女", style: UIAlertActionStyle.default, handler: { (alert) in
            self.changeSex(sex: "女")
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    func changeSex(sex: String) {
        
        let newSex = sex == "男" ? "1" : "2"
        let params = ["user_sex": newSex,
                      "user_id": LoginModel.load()!.user_id]
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.change, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            super.hudWithMssage(msg: "更新成功")
            self.sex = sex
            LoginModel.update(value: self.sex == "男" ? "1" : "2" , key: "user_sex")
        }
    }
    
    // MARK: - click birth day
    func  didClickBirthDay() {
        
        let picker = ECStroryBoard.view(type: MiniDetailsDatePicker.self)
        UIApplication.shared.keyWindow?.addSubview(picker)
        picker.dateChose = { (date) in
            self.changeBirtyDay(birthDay: date)
        }
    }
    
    func changeBirtyDay(birthDay: String) {
        
        let newBirthDay = birthDay
        let params = ["user_birthday": newBirthDay,
                      "user_id": LoginModel.load()!.user_id]
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.change, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            super.hudWithMssage(msg: "更新成功")
            self.birthday = birthDay
            LoginModel.update(value: birthDay, key: "user_birthday")
        }
    }
    
    // MAKR: - photo
    func openPhoto(type: UIImagePickerControllerSourceType) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = type
        imagePickerController.navigationBar.tintColor = UIColor.darkGray
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            present(imagePickerController, animated: true, completion:nil)
        }
    }
    
    // MARK: - update name
    func updateName() {
        
        tableView.reloadRows(at: [NSIndexPath(row: 0, section: 1) as IndexPath], with: UITableViewRowAnimation.none)
    }
    
    // MARK: - update header image
    func updateHeaderImage() {
        
        tableView.reloadRows(at: [NSIndexPath(row: 0, section: 0) as IndexPath], with: UITableViewRowAnimation.none)
    }
    
    // MARK: - update Sex
    func updateSex() {
        
        tableView.reloadRows(at: [NSIndexPath(row: 1, section: 0) as IndexPath], with: UITableViewRowAnimation.none)
    }
    
    // MARK: - update BirthDay
    func updateBirthDay() {
        
        tableView.reloadRows(at: [NSIndexPath(row: 2, section: 0) as IndexPath], with: UITableViewRowAnimation.none)
    }
    
    // MARK: - update department
    func updateDepartment() {
        
         tableView.reloadRows(at: [NSIndexPath(row: 3, section: 1) as IndexPath], with: UITableViewRowAnimation.none)
    }
    
    // MARK: - update phone 
    func updatePhone() {
        
         tableView.reloadRows(at: [NSIndexPath(row: 1, section: 1) as IndexPath], with: UITableViewRowAnimation.none)
    }
    
    // MARK: - update enterprise
    func updateEnterprise() {
       
        tableView.reloadRows(at: [NSIndexPath(row: 2, section: 1) as IndexPath], with: UITableViewRowAnimation.none)
        
    }
}
// MARK: - UIImagePickerControllerDelegate
extension MineDetailsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    @objc func dismissPicker(picker: UIViewController) {
        
        imagePickerControllerDidCancel(picker as! UIImagePickerController)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type:String = (info[UIImagePickerControllerMediaType]as!String)
        //当选择的类型是图片
        if type=="public.image"
        {
            let img = info[UIImagePickerControllerOriginalImage] as? UIImage
            updateImage(img: img)
            picker.dismiss(animated:true, completion:nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func updateImage(img: UIImage?) {
        
        let imgData = UIImageJPEGRepresentation(img!,0.5)
        if let imgData = imgData {
            
            let base64DateString = imgData.base64EncodedString()
            let loginModel = LoginModel.load()!
            let params = ["user_id": loginModel.user_id,
                          "user_photo": base64DateString,
                          "photo_type": "jpg"]
            UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.photo, params: params, handle: { (response, isLoadFaild, errorMsg) in
                
                if isLoadFaild {
                    return super.hudWithMssage(msg: errorMsg)
                }
                
                self.updateLocalImageWithResponse(response: response)
                super.hudWithMssage(msg: "更新成功")
                self.image = img!
            })
            
        }
    }

    func updateLocalImageWithResponse(response: [String: Any]?) {
        
        guard let response = response else {
            return
        }
        
        guard let data = response["data"] as? [String: Any] else {
            return
        }
        
        if let imageUrl = data["face_image_url"] as? String {
            
            LoginModel.update(value: imageUrl, key: "face_image_url")
        }
        
    }
}
extension LoginModel {
    var stringSex: String {
        return user_sex == "1" ? "男" : user_sex == "2" ? "女" : "未知"
    }
}
