//
//  MedicalProductDetailsPopCollectionViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/28.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import DeckTransition

enum ProductDetailsType {
    case Normal
    case AddShoppingCar
    case SureShopping
}

class MedicalProductDetailsPopViewController: BaseViewController
{
    
    var type: ProductDetailsType = .Normal
    var model: MedicalProductDetailsModel?
    var selected: ((String, String) -> Void)?
    var successAddShoppingCar: (() -> Void)?

    @IBOutlet weak var displayStroeNumber: UILabel!
    @IBOutlet weak var displayPrice: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet weak var icon: UIImageView!
    fileprivate var bar: MedicalProductDetailsFooter?
    fileprivate enum ReuseIdentifier {
        static let Address = "Pop Address"
        static let Content = "Content"
        
        static let Normal = "Normal"
    }
    
    fileprivate enum ItemSize {
        static let Address = CGSize(width: Screen.width, height: 44)
        static let Color = CGSize(width: (Screen.width - 20) / 3, height: 30)
        static let Ret = CGSize(width: (Screen.width - 20 ) / 2, height: 50)
    }
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        removeBar()
        configCollectionView()
        updateUI()
    }
    
    deinit {
        addBar()
    }
    
    @IBOutlet weak var displayNumber: UILabel!
    
    @IBAction func sureAction() {
     
        switch type {
        default:
            // 遍历选中属性是否全选 全选返回，未选完 要求选完
            let selectedModel = isAllSelected()
            if selectedModel.isSelected {
                
                if let selected = selected {
                    selected(selectedModel.selectedString, recordNumber)
                }
                close()
            }
            
            else {
                
                super.hudWithMssage(msg: "\(selectedModel.unselectedType)")
            }
            
        }
        
        
    }
    
    
    var recordNumber: String {
        set {
            
            displayNumber.text = newValue
        }
        
        get {
            return displayNumber.text!
        }
    }
    
    fileprivate struct SelectedModel {
        
        let isSelected: Bool
        let unselectedType: String
        let selectedString: String
    }
    
    fileprivate func isAllSelected() -> SelectedModel {
        
        var isAllselected = false
        
        var sectionTitle = "已选: "
        var unSelectedTitle = "请选择: "
        if self.model?.attrs == nil {
            return SelectedModel(isSelected: true, unselectedType: "", selectedString: "无")
        }
        
        for section in self.model!.attrs! {
            
            sectionTitle += "\(section.attr_name):"
            var isSelected = false
            for row in section.subAttrs! {
                
                if row.isSelected {
                    sectionTitle += "\(row.attr_value) "
                    isSelected = true
                }
            }
            
            isAllselected = isSelected
            if isAllselected == false {
                unSelectedTitle += "\(section.attr_name)"
                return SelectedModel(isSelected: isAllselected, unselectedType: unSelectedTitle, selectedString: sectionTitle)
            }
            
        }
        
        return SelectedModel(isSelected: isAllselected, unselectedType: unSelectedTitle, selectedString: sectionTitle)
    }
    
    fileprivate func updateUI() {
        
        if model == nil { return }
        
        icon.sd_setImage(with: model!.iconURL, placeholderImage: Placeholder.DefaultImage)
        displayStroeNumber.text = "库存:\(model!.inventory_num)"
        displayPrice.text = model!.marketPrice
    }
    
    @IBAction func add() {
        
        let max = self.model == nil ? 0 : self.model!.inventory_num.toInt()!
        
        var currentNumber = Int(displayNumber.text!)!
        currentNumber += 1
        if currentNumber > max {
            currentNumber = max
        }
        
        recordNumber = String(currentNumber)
    }
    
    @IBAction func subtract() {
        
        
        var currentNumber = Int(displayNumber.text!)!
        currentNumber -= 1
        if currentNumber < 1 {
            currentNumber = 1
        }
        
        recordNumber = String(currentNumber)
    }
    
    
    fileprivate func removeBar() {
        
        let subViews = UIApplication.shared.keyWindow!.subviews
        for sub in subViews {
            if sub.isKind(of: MedicalProductDetailsFooter.classForCoder()) {
                bar = sub as? MedicalProductDetailsFooter
                bar?.removeFromSuperview()
            }
        }
    }
    
    fileprivate func addBar() {
        
        if let bar = bar {
            UIApplication.shared.keyWindow?.addSubview(bar)
        }
    }
   
    
    fileprivate func configCollectionView() {
       
        // 注册内容cell
        collectionView?.register(MedicalProductDetailsPopRowThreeCollectionViewCell.nib, forCellWithReuseIdentifier: ReuseIdentifier.Content)
        
        collectionView?.register(MedicalProductDetailsPopNormalHeader.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Normal)
    }
    
    
    
}
// MARK: UICollectionViewDataSource
extension MedicalProductDetailsPopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return self.model == nil ? 0 : self.model!.attrs == nil ? 0 : self.model!.attrs!.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.model == nil ? 0 : self.model!.attrs![section].subAttrs!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.Content, for: indexPath)
        
        if let cell = cell as? MedicalProductDetailsPopRowThreeCollectionViewCell {
            
            cell.model = self.model?.attrs?[indexPath.section].subAttrs?[indexPath.row]
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Normal, for: indexPath)
        (header as! MedicalProductDetailsPopNormalHeader).model = self.model?.attrs?[indexPath.section]
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let newModel = model!
        
        for section in 0..<newModel.attrs!.count {
            
            if section == indexPath.section {
                
                let sectionArr = NSMutableArray()
                for row in 0..<newModel.attrs![section].subAttrs!.count {
                    
                    var selectedModel = newModel.attrs![section].subAttrs![row]

                    if row == indexPath.row {
                        
                        selectedModel.isSelected = true
                    }
                    else {
                        
                        selectedModel.isSelected = false
                    }
                    
                    sectionArr.add(selectedModel)
                }
                
                newModel.attrs?[section].subAttrs = sectionArr as? [MedicalProductDetailsModel.SubAttrVal]
                DispatchQueue.main.async {
                    collectionView.reloadSections(NSIndexSet(index: section) as IndexSet)
                }
            }
            
        }
        
        model = newModel
       
    }
    
    
}

extension MedicalProductDetailsPopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: Screen.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
         return ItemSize.Color
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch section {
        case 0: return 4
        case 1: return 10
        default: return 0.003
        }
    }
}
// MARK: - MedicalProductDetailsPopRowThreeCollectionViewCellDelegate
extension MedicalProductDetailsPopViewController {
    
    func updateRets(indexPath: IndexPath) {
        
        let newRets = NSMutableArray()
        
        DispatchQueue.main.async {
            self.collectionView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet)
        }
    }
    
    func updateColors(indexPath: IndexPath) {
        
        let newRets = NSMutableArray()
        
        DispatchQueue.main.async {
            self.collectionView.reloadSections(NSIndexSet(index: indexPath.section) as IndexSet)
        }
    }
    
}
fileprivate extension MedicalProductDetailsModel {
    
    var iconURL: URL {
        
        return URL(string: "\(host):\(picPort)/\(objectAddress)\(product_image_url)")!
    }
}
