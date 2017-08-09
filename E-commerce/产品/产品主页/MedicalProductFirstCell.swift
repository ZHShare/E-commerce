//
//  MedicalProductFirstCell.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/24.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

fileprivate enum ReuseIdentifier  {
    static let buttons = "Display Images and Titles"
}

protocol MedicalProductFirstCellDelegate {
    
    func didSelectedIndex(index: IndexPath)
}

class MedicalProductFirstCell: UICollectionViewCell {

    var models: [ButtonModel]? { didSet { refreshButtons() } }
    var notices: [PreferentialModel]? { didSet { refreshNotices() }}
    var delegate: MedicalProductFirstCellDelegate?
    @IBOutlet weak var moreBg: UIView! { didSet { updateBoxUI() } }
    
    fileprivate func updateBoxUI() {
        moreBg.layer.cornerRadius = moreBg.bounds.height / 2
        moreBg.layer.borderColor = UIColor.gray.cgColor
        moreBg.layer.masksToBounds = true
        moreBg.layer.borderWidth = 1
    }
    
    @IBOutlet weak var buttonsView: UICollectionView! {
        didSet { updateButtonsView() }
    }
    
    @IBAction func more() {
        print("更多")
    }
    
    // 上下滚动广告
    @IBOutlet weak var adScrollView: UIScrollView!
    
    
    fileprivate func updateButtonsView() {
        
        //注册一个cell
        buttonsView!.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: ReuseIdentifier.buttons)
        
    }
    
    fileprivate func refreshButtons() {
        
        DispatchQueue.main.async { [unowned self] in
            self.buttonsView.reloadData()
        }
    }
    
    fileprivate func refreshNotices() {
        
        adScrollView.removeSubviews()
        guard let notices = notices else {
            return
        }
        let contentSize = CGSize(width: 0, height: adScrollView.bounds.height*CGFloat(notices.count))
        adScrollView.contentSize = contentSize
        
        var frame = adScrollView.frame
        frame.origin.x = 0
        
        var index = 0
        for model in notices {
            
            frame.origin.y = CGFloat(index) * adScrollView.frame.height
            
            let titleLabel = UILabel(frame: frame)
            titleLabel.font = UIFont.systemFont(ofSize: 12)
            titleLabel.textColor = UIColor.gray
            titleLabel.text = model.notice_title
            adScrollView.addSubview(titleLabel)
            
            index += 1
        }

        
    }
    

}

// MARK: - UICollectionViewDelegate UICollectionViewDatasource
extension MedicalProductFirstCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let models = models {
            return models.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReuseIdentifier.buttons, for: indexPath) as? ProductCollectionViewCell {
            
            cell.model = models?[indexPath.row]
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.didSelectedIndex(index: indexPath)
    }
    
}
// MARK: UICollectionViewDelegateFlowLayout
extension MedicalProductFirstCell: UICollectionViewDelegateFlowLayout {
    
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

