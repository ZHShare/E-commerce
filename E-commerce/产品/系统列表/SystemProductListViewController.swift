//
//  SystemProductListViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/16.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class SystemProductListViewController: BaseViewController
{

    fileprivate var packs: [ProductModel]? {
        didSet { updateUI() }
    }
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet { configCollectionView() }
    }
    @IBOutlet weak var synthesizeButton: UIButton! {
        didSet { exchangeButton = synthesizeButton }
    }
    fileprivate var exchangeButton: UIButton!
    
    @IBOutlet weak var salesVolumeButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    fileprivate var params: [String: Any] = ["order_sort": "1",
                                             "product_type": "2"]
    fileprivate func updateUI() {
        
        if packs == nil { return }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    @IBAction func topAction(sender: UIButton) {
        
        exchangeButton.isSelected = false
        exchangeButton = sender
        exchangeButton.isSelected = true
        
        params["order_sort"] = "\(sender.tag)"
        fetchData()
    }
    
    fileprivate enum ReuseIdentifier {
        static let System = "System Cell"
    }
    
    fileprivate enum ItemSize {
        
        static let System = CGSize(width: Screen.width, height: 236)

    }
    
    fileprivate func fetchData() {
      
        HomeNet.fetchDataWith(transCode: TransCode.Home.type, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.packs = ProductModel.models(withResponse: response, isNormal: false)
        }
    }
    
    fileprivate func configCollectionView() {
        
        // 注册系统套餐cell
        collectionView.register(UINib(nibName: "MedicalProductSystemCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.System)
        
    }

}
// MARK: UICollectionViewDelegate UICollectionViewDatasource
extension SystemProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return packs == nil ? 0 : packs!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.System, for: indexPath) as! MedicalProductSystemCell
            
        cell.productModel = packs?[indexPath.row]
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productDetailsController = ECStroryBoard.controller(type: MedicalProductDetailsViewController.self)
        productDetailsController.productID = packs![indexPath.row].product_id
        navigationController?.ecPushViewController(productDetailsController)
    }
   
    
}
extension SystemProductListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return ItemSize.System
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
