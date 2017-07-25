//
//  WorkViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/25.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit


class WorkViewController: UICollectionViewController {
  
    fileprivate enum ReuseIdentifier {
        static let header = "Work Top"
        static let main = "Display Images and Titles"
    }
    
    fileprivate enum ItemSize {
        static let size = CGSize(width: (Screen.width - 9) / 3, height: 90)
    }
    
    var models: [WorkModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        config()
        fetchData()
    }

    fileprivate func fetchData() {
        
        models = WorkModel.models()
        DispatchQueue.main.async {
            self.collectionView?.reloadData()
        }
    }
    
    fileprivate func config() {
        
        // 注册头
        collectionView?.register(UINib(nibName: "WorkReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.header)
        
        // 注册cell
        collectionView?.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.main)
    }

    fileprivate func enterLogin() {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let logNav = storyboard.instantiateViewController(withIdentifier: "BaseNavigationController") as? BaseNavigationController {
            present(logNav, animated: true, completion: nil)
        }
    }

}
// MARK: UICollectionViewDelegateFlowLayout
extension WorkViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return ItemSize.size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: Screen.width, height: 227)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.001
    }
}

// MARK: UICollectionViewDataSource
extension WorkViewController {
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let models = models {
            return models.count
        }
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.main, for: indexPath)
        
        (cell as! ProductCollectionViewCell).workModel = models?[indexPath.row]
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.header, for: indexPath)
        
        if let header = header as? WorkReusableView {
            header.delegate = self
        }
        
        return header
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if LoginStatus.isLogined { return }
        enterLogin()
    }
    
}
// MARK: UIResableViewDelegate
extension WorkViewController: UIResableViewDelegate {
    
    func didClickArea() {
        
        if LoginStatus.isLogined { return }
        enterLogin()
    }
}

// MARK: UICollectionViewDelegate
extension WorkViewController {
    
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
}
