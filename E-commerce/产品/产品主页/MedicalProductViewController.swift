//
//  MedicalProductViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductViewController: BaseViewController {

    fileprivate var adModels: [ADModel]?
    fileprivate var buttonModels: [ButtonModel]?
    fileprivate var notices: [PreferentialModel]?
    fileprivate var packs: [PackModel]?
    fileprivate var products: [ProductModel]?
    
    @IBOutlet weak var collectionView: UICollectionView! { didSet { configCollectionView() } }
    @IBOutlet weak var navigationBarShowdow: UIView!
    
    @IBAction func search() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    fileprivate func fetchData() {
        
        HomeNet.fetchDataWith(transCode: TransCode.Home.mainPage, params: [String: Any]()) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            let model = MedicalProductModel.modelWithResponse(response: response)
            if let adms = model.0 {
                self.adModels = adms
            }
            if let buts = model.1 {
                self.buttonModels = buts
            }
            if let nots = model.2 {
                self.notices = nots
            }
            if let pac = model.3 {
                self.packs = pac
            }
            
            if let products = model.4 {
                self.products = products
            }
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
    }
    
    @IBAction func shopping() {
        
        if LoginStatus.isLogined {
            
            let shoppingCarViewController = ECStroryBoard.controller(type: ShoppingCarViewController.self)
            navigationController?.ecPushViewController(shoppingCarViewController, animated: true, isHidesBottomBarWhenPushed: false)
            return
        }
        
        enterLogin()
    }
}

// MARK: Fileprivate 
fileprivate extension MedicalProductViewController {
    
    enum ReuseIdentifier {
        static let header = "AD Scroll"
        static let buttons = "Buttons"
        static let normalHeader = "System and List"
        static let system = "System Cell"
        static let list = "List Cell"
    }
    
    enum ItemSize {
        static let buttons = CGSize(width: Screen.width, height: 251)
        static let system = CGSize(width: Screen.width, height: 236)
        
        static func listForImage(image: UIImage) -> CGSize {
            
            let imageHeight = image.size.height
            let size = CGSize(width: (Screen.width - 6) / 2.0, height: imageHeight + 86.0)
            
            return size
        }
    }
    
    enum HeaderSize {
        static let ad = CGSize(width: Screen.width, height: 200)
        static let normal = CGSize(width: Screen.width, height: 30)
    }
    
    func configCollectionView() {
        
        automaticallyAdjustsScrollViewInsets = false
        
        // 注册轮播头
        collectionView.register(MedicalProductHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.header)
        
        // 注册标题头
        collectionView.register(UINib(nibName: "MedicalProductNormalHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.normalHeader)
        
        // 注册按钮cell
        collectionView.register(UINib(nibName: "MedicalProductFirstCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.buttons)
        
        // 注册系统套餐cell
        collectionView.register(UINib(nibName: "MedicalProductSystemCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.system)
        
        // 注册产品列表cell
        collectionView.register(UINib(nibName: "MedicalProductListCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.list)
    }
    
}

// MARK: MedicalProductFirstCellDelegate
extension MedicalProductViewController: MedicalProductFirstCellDelegate {
    
    func didSelectedIndex(index: IndexPath) {
        
        let classifyViewController = ECStroryBoard.controller(type: ProductClassifyViewController.self)
        navigationController?.ecPushViewController(classifyViewController)  
    }
}

// MARK: UICollectionViewDelegate UICollectionViewDatasource
extension MedicalProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 2 {
            return products == nil ? 0 : products!.count
        }
        
        else if section == 1 {
            return packs == nil ? 0 : packs!.count
        }
        
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        switch indexPath.section {
        case 0:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.buttons, for: indexPath) as? MedicalProductFirstCell {
                cell.models = buttonModels
                cell.notices = notices
                cell.delegate = self
                return cell
            }
        case 1:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.system, for: indexPath) as? MedicalProductSystemCell {
                cell.model = packs?[indexPath.row]
                return cell
            }
        case 2:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.list, for: indexPath) as? MedicalProductListCell {
                
                cell.model = products?[indexPath.row]
                return cell
            }
        default:
            break
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let productDetailsController = ECStroryBoard.controller(type: MedicalProductDetailsViewController.self)
        navigationController?.ecPushViewController(productDetailsController)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.header, for: indexPath) as? MedicalProductHeader {
                
                header.models = adModels
                return header
            }
        }
        
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.normalHeader, for: indexPath) as? MedicalProductNormalHeader {
            
            switch indexPath.section {
            case 1: header.displayTitle.text = "系统套餐"
            case 2: header.displayTitle.text = "产品列表"
            default:
                break
            }
            
            return header
        }
        
        return UICollectionReusableView()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 64 {
            navigationBarShowdow.alpha = 1
        }
            
        else if contentOffsetY < 0 {
            navigationBarShowdow.alpha = 0
        }
        
        else {
            
            let alpha = contentOffsetY / 64
            UIView.animate(withDuration: 0.5, animations: {
                
                self.navigationBarShowdow.alpha = alpha
            }, completion: nil)
        }
        
    }

    
}
extension MedicalProductViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        switch indexPath.section {
        case 0: return ItemSize.buttons
        case 1: return ItemSize.system
        case 2: return ItemSize.listForImage(image: products![indexPath.row].image)

        default:
            return CGSize.zero
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        switch section {
        case 0: return HeaderSize.ad
        default: return HeaderSize.normal
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.001
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(1, 1, 0, 1)
    }
    
}

