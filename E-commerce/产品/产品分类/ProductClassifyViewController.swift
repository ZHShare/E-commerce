//
//  ProductClassifyViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/9.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductClassifyViewController: BaseViewController
{

    fileprivate enum ReuseIdentifier {
        static let Calssify = "Calssify"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
   
    @IBOutlet weak var collectionView: UICollectionView!
}
// MARK: 
extension ProductClassifyViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.Calssify, for: indexPath)
        
        return cell
    }
    
}
