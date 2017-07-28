//
//  MedicalProductDetailsPopCollectionViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/28.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import DeckTransition

class MedicalProductDetailsPopViewController: BaseViewController
{
    
    @IBOutlet var collectionView: UICollectionView!
    var colors: [MedicalProductDetailsPopModel.Color]?
    var rets: [MedicalProductDetailsPopModel.Related]?
    
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
        
    }
    
    deinit {
        addBar()
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
        
        UIApplication.shared.keyWindow!.addSubview(bar!)
    }
    
    fileprivate func fetchData() {
        
        colors = MedicalProductDetailsPopModel.Color.models()
        rets = MedicalProductDetailsPopModel.Related.models()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    fileprivate func configCollectionView() {
        
        // 注册地址cell
        collectionView?.register(MedicalProductDetailsPopAddressCollectionViewCell.nib, forCellWithReuseIdentifier: ReuseIdentifier.Address)
        
        // 注册内容cell
        collectionView?.register(MedicalProductDetailsPopRowThreeCollectionViewCell.nib, forCellWithReuseIdentifier: ReuseIdentifier.Content)
        
        collectionView?.register(MedicalProductDetailsPopNormalHeader.nib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Normal)
        
        
        fetchData()
    }
    
    
    
}
// MARK: UICollectionViewDataSource
extension MedicalProductDetailsPopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 3
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section {
        case 0:  return 1
        case 1:  return colors == nil ? 0 : colors!.count
        case 2:  return rets == nil ? 0 : rets!.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.Address, for: indexPath)
            return cell
        }
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.Content, for: indexPath)
            
            if let cell = cell as? MedicalProductDetailsPopRowThreeCollectionViewCell {
                
                if let colors = colors {
                    cell.color = colors[indexPath.row]
                    return cell
                }
            }
            
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.Content, for: indexPath)
        
        if let cell = cell as? MedicalProductDetailsPopRowThreeCollectionViewCell {
            
            if let colors = rets {
                cell.ret = colors[indexPath.row]
                return cell
            }
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        
        switch indexPath.section {
        case 0:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Normal, for: indexPath)
            return header
        case 1:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Normal, for: indexPath)
            return header
        case 2:
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Normal, for: indexPath)
            return header
        default: break
            
        }
        
        return UICollectionReusableView(frame: CGRect.zero)
    }
    
    
}

extension MedicalProductDetailsPopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: Screen.width, height: 40)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch indexPath.section {
        case 0: return ItemSize.Address
        case 1: return ItemSize.Color
        case 2: return ItemSize.Ret
        default: return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        switch section {
        case 1: return 4
        case 2: return 10
        default: return 0.003
        }
    }
}
