//
//  MineDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/2.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import MWPhotoBrowser

class MineDetailsViewController: BaseTableViewController
{

    fileprivate enum ReuseIdentifier {
        static let Header = "Header Image"
        static let Normal = "Normal"
    }
    
    fileprivate var titles: [[MineDetailsTitleModel]]?
    
    fileprivate var department: MineDetailsDepartmentModel = MineDetailsDepartmentModel(title: "") {
        didSet { updateDepartment() }
    }
    
    fileprivate var name: String = "" {
        didSet { updateName() }
    }
    
    fileprivate var image: UIImage = UIImage() {
        didSet { updateHeaderImage() }
    }
    fileprivate var sex: String = "" {
        didSet { updateSex() }
    }
    fileprivate var birthday: String = "" {
        didSet { updateBirthDay() }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configTitle()
        configNavigationBar()
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
                case 1: (cell as? MineDetailsNormalTableViewCell)?.accessoryType = UITableViewCellAccessoryType.none
                case 2: (cell as? MineDetailsNormalTableViewCell)?.accessoryType = UITableViewCellAccessoryType.none
                case 3: (cell as? MineDetailsNormalTableViewCell)?.displaySubTitle.text = department.title

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
            self.department = model
        }
    }
    
    // MAKR: - click name
    func didClickName() {
        
        let changeNameController = ECStroryBoard.controller(type: MineDetailsChangeViewController.self)
        navigationController?.ecPushViewController(changeNameController)
        changeNameController.done = { (name) in
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
            self.sex = "男"
        }))
        alertController.addAction(UIAlertAction(title: "女", style: UIAlertActionStyle.default, handler: { (alert) in
            self.sex = "女"
        }))
        alertController.addAction(UIAlertAction(title: "取消", style: UIAlertActionStyle.cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - click birth day
    func  didClickBirthDay() {
        
        let picker = ECStroryBoard.view(type: MiniDetailsDatePicker.self)
        UIApplication.shared.keyWindow?.addSubview(picker)
        picker.dateChose = { (date) in
            self.birthday = date
        }
    }
    
    // MAKR: - photo
    func openPhoto(type: UIImagePickerControllerSourceType) {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        imagePickerController.sourceType = type
        
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
    
}
// MARK: - UIImagePickerControllerDelegate
extension MineDetailsViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let type:String = (info[UIImagePickerControllerMediaType]as!String)
        //当选择的类型是图片
        if type=="public.image"
        {
            let img = info[UIImagePickerControllerOriginalImage] as? UIImage
            image = img!
            let imgData = UIImageJPEGRepresentation(image,0.5)
            picker.dismiss(animated:true, completion:nil)
        }
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
