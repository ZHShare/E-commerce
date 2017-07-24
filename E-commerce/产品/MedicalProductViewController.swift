//
//  MedicalProductViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView! { didSet { configCollectionView() } }
    @IBOutlet weak var navigationBarShowdow: UIView!
    
    @IBAction func search() {
    }
}

// MARK: Fileprivate 
fileprivate extension MedicalProductViewController {
    
    enum ReuseIdentifier {
        static let header = "AD Scroll"
        static let buttons = "Buttons"
        static let normalHeader = "System and List"
    }
    
    func configCollectionView() {
        
        // 注册轮播头
        collectionView.register(MedicalProductHeader.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.header)
        
        // 注册标题头
        collectionView.register(UINib(nibName: "MedicalProductNormalHeader", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.normalHeader)
        
        // 注册按钮cell
        collectionView.register(UINib.init(nibName: "MedicalProductFirstCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.buttons)
    }
    
}

// MARK: UICollectionViewDelegate UICollectionViewDatasource
extension MedicalProductViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.buttons, for: indexPath) as? MedicalProductFirstCell {
            return cell
        }
        
        
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if indexPath.section == 0 {
            
            
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.header, for: indexPath) as? MedicalProductHeader {
                
                return header
            }
        }
        
        if let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.normalHeader, for: indexPath) as? MedicalProductNormalHeader {
            
            if indexPath.section == 1 {
                header.displayTitle.text = "系统套餐"
            }
            
            else if indexPath.section == 2 {
                header.displayTitle.text = "产品列表"
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
        
        if indexPath.section == 0 {
            return CGSize(width: Screen.width, height: 251)
        }
        else {
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if section == 0 {
            return CGSize(width: Screen.width, height: 200)
        }
        
        return CGSize(width: Screen.width, height: 30)
    }
    
}
