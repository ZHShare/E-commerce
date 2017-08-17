//
//  ProductListViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/15.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductListViewController: BaseViewController
{

    var searchText: String?
    var cat_id: String?
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet { configCollectionView() }
    }
    @IBOutlet weak var synthesizeButton: UIButton! {
        didSet { exchangeButton = synthesizeButton }
    }
    @IBOutlet weak var salesVolumeButton: UIButton!
    @IBOutlet weak var promoteSalesButton: UIButton!
    
    fileprivate var exchangeButton: UIButton!
    fileprivate var models: [ProductModel]? {
        didSet { updateUI() }
    }
    fileprivate var parms: [String: Any] = ["order_sort": "1",
                                            "product_type": "1"]
    
    @IBAction func topAction(sender: UIButton) {
    
        exchangeButton.isSelected = false
        exchangeButton = sender
        exchangeButton.isSelected = true
        
        parms["order_sort"] = "\(sender.tag)"
        fetchData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    fileprivate func updateUI() {
        
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }

    fileprivate enum ReuseIdentifier {
        static let List = "List Cell"
    }
    
    fileprivate enum ItemSize {
        
        static func listForImage(image: UIImage) -> CGSize {
            
            let imageHeight = image.size.height
            let size = CGSize(width: (Screen.width - 6) / 2.0, height: imageHeight + 100)
            
            return size
        }
    }
    
    fileprivate func fetchData() {
        
        parms["product_name"] = searchText ?? ""
        parms["cat_id"] = cat_id ?? ""
        HomeNet.fetchDataWith(transCode: TransCode.Home.type, params: parms) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.models = ProductModel.models(withResponse: response)
        }
    }
    
    fileprivate func configCollectionView() {
       
        // 注册产品列表cell
        collectionView.register(UINib(nibName: "MedicalProductListCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.List)
    }

}
// MARK: - UICOllectionView delegate datasource
extension ProductListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models == nil ? 0 : models!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.List, for: indexPath)
        
        (cell as! MedicalProductListCell).model = models?[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let productDetailsController = ECStroryBoard.controller(type: MedicalProductDetailsViewController.self)
        
        productDetailsController.productID = models![indexPath.row].product_id
        
        navigationController?.ecPushViewController(productDetailsController)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return ItemSize.listForImage(image: models![indexPath.row].image)
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
