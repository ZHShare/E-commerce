//
//  ProductFirstTableViewCell.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
fileprivate enum ReuseIdentifier  {
    static let buttons = "Display Images and Titles"
}

struct ADModel {
    
    let title: String
    
    static func fecthDatas() -> [ADModel] {
        
        var models = [ADModel]()
        
        for title in ["系统新上线，全部产品5折",
                      "系统套餐,5.5折起",
                      "半个月内订单付款,4折起"] {
                        
                        let model = ADModel(title: title)
                        models.append(model)
        }
        
        return models
    }
}

struct ButtonModel {
    
    let title: String
    let imageString: String
    
    static func fetchDatas() -> [ButtonModel] {
        
        var models = [ButtonModel]()
        
        for dic in [["title": "传呼类", "imageString": "product_call1"],
                    ["title": "护理系统", "imageString": "product_nurse"],
                    ["title": "传呼类", "imageString": "product_call"],
                    ["title": "消毒机", "imageString": "product_disinfect"],
                    ["title": "输液报警器", "imageString": "product_infusion"],
                    ["title": "制氧机", "imageString": "product_make_oxygen"],
                    ["title": "工程设计", "imageString": "product_engineering"],
                    ["title": "工程产品", "imageString": "pruduct_device"]] {
                        
                        
                        let model = ECMapping.ace(type: ButtonModel.self, fromDic: dic)
                        models.append(model)
        }
        
        return models
    }
}

class ProductFirstTableViewCell: UITableViewCell {

   
    
    @IBOutlet weak var moreBg: UIView! {
        didSet {
            
            moreBg.layer.cornerRadius = moreBg.bounds.height / 2
            moreBg.layer.borderColor = UIColor.gray.cgColor
            moreBg.layer.masksToBounds = true
            moreBg.layer.borderWidth = 1
        }
    }
   
    @IBOutlet weak var buttonsView: UICollectionView! { didSet { updateButtonsView() } }
    
    @IBAction func more() {
        print("更多")
    }
    
    
    @IBOutlet weak var adScrollView: UIScrollView! { didSet { updateADScrollView() } }
    
    
    
    fileprivate func updateButtonsView() {
    
        
        //注册一个cell
        buttonsView! .register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.buttons)
        
    }
    
    fileprivate func updateADScrollView() {
        
        let models = ADModel.fecthDatas()
        let contentSize = CGSize(width: 0, height: adScrollView.bounds.height*CGFloat(models.count))
        adScrollView.contentSize = contentSize
        
        var frame = adScrollView.frame
        frame.origin.x = 0
        
        var index = 0
        for model in models {
            
            frame.origin.y = CGFloat(index) * adScrollView.frame.height
            
            let titleLabel = UILabel(frame: frame)
            titleLabel.font = UIFont.systemFont(ofSize: 12)
            titleLabel.textColor = UIColor.gray
            titleLabel.text = model.title
            adScrollView.addSubview(titleLabel)
            
            index += 1
        }
    }
}

// MARK: - UICollectionViewDelegate UICollectionViewDatasource
extension ProductFirstTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ButtonModel.fetchDatas().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.buttons, for: indexPath) as? ProductCollectionViewCell {
            
            cell.model = ButtonModel.fetchDatas()[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    
}
// MARK: UICollectionViewDelegateFlowLayout
extension ProductFirstTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (Screen.width - 10) / 4.0
        let height = (collectionView.bounds.height - 8) / 2.0
        
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0001
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0001
    }
}
