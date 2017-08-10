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
        static let List = "List"
        static let Header = "Header"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchFirstClassifyData()
    }
   
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentView: UICollectionView! {
        didSet { configContentView() }
    }
    
    fileprivate var subs: [SecondClassifyModel]?
    fileprivate var firstClassifyModels: [FirstClassifyModel]?
    fileprivate func configContentView() {
       
        contentView.register(UINib(nibName: "ProductClassifyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.Calssify)
        
        contentView.register(UINib(nibName: "ProductClassifyCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Header)
    }
    
    fileprivate func fetchFirstClassifyData() {
        
        HomeNet.fetchDataWith(transCode: TransCode.Home.firstClass, params: [String : Any]()) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            if let models = FirstClassifyModel.models(withDic: response) {
               
                self.firstClassifyModels = models
                self.fetchSecondClassifyDataWithFirstClass(classs: models[0])
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.tableView.selectRow(at: NSIndexPath(row: 0, section: 0) as IndexPath, animated: true, scrollPosition: UITableViewScrollPosition.none)
                }
            }
            
        }
    }
    
    fileprivate func fetchSecondClassifyDataWithFirstClass(classs: FirstClassifyModel) {
        
        let params = ["cat_id": classs.cat_id]
        
        HomeNet.fetchDataWith(transCode: TransCode.Home.secondClass, params: params) { (response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return super.hudWithMssage(msg: errorMsg)
            }
            
            self.subs = SecondClassifyModel.models(withDic: response)
            DispatchQueue.main.async {
                self.contentView.reloadData()
            }
        }
        
    }
    
}

// MARK: - UITableView Delegate Datasource
extension ProductClassifyViewController: UITableViewDelegate, UITableViewDataSource {
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return firstClassifyModels == nil ? 0 : firstClassifyModels!.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.List, for: indexPath)
            (cell as! ProductClassifyListCell).model = firstClassifyModels?[indexPath.row]

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedModel = firstClassifyModels![indexPath.row]
        fetchSecondClassifyDataWithFirstClass(classs: selectedModel)
    }
}
extension ProductClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return subs == nil ? 0 : subs!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subs == nil ? 0 : subs![section].subs!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.Calssify, for: indexPath)
        (cell as! ProductClassifyCollectionViewCell).model = subs?[indexPath.section].subs?[indexPath.row]
        return cell
    }
    
     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
     
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: ReuseIdentifier.Header, for: indexPath)
        
        (header as? ProductClassifyCollectionReusableView)?.model = subs?[indexPath.section]
        
        return header
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        return CGSize(width: collectionView.w, height: 30)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: (collectionView.w)/2, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}
