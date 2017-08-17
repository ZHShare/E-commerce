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

@objc protocol MedicalProductFirstCellDelegate {
    
    func didSelectedModel(model: Any)
    func didClickNotice(notice: Any)
    func moreNotice()
}

class MedicalProductFirstCell: UICollectionViewCell {

    var models: [ButtonModel]? { didSet { refreshButtons() } }
    var notices: [PreferentialModel]? { didSet { refreshNotices() }}
    weak var delegate: MedicalProductFirstCellDelegate?
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
        
        delegate?.moreNotice()
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
    fileprivate var timer: Timer?
    @objc fileprivate func timerA() {
        
        if currentContentSizeHeight == adScrollView.contentSize.height - adScrollView.frame.size.height {
            currentContentSizeHeight = 0
             adScrollView.setContentOffset(CGPoint(x: 0, y: currentContentSizeHeight), animated: false)
        }
        
        else {
            currentContentSizeHeight += adScrollView.frame.size.height
            adScrollView.setContentOffset(CGPoint(x: 0, y: currentContentSizeHeight), animated: true)
        }
        
    }
    
    fileprivate var currentContentSizeHeight: CGFloat = 0
    fileprivate func refreshNotices() {
        
        adScrollView.removeSubviews()
        guard let notices = notices else {
            return
        }
        let contentSize = CGSize(width: 0, height: adScrollView.bounds.height*CGFloat(notices.count))
        if adScrollView.contentSize != contentSize {
            adScrollView.contentSize = contentSize
        }
        
        if timer == nil {
             timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerA), userInfo: nil, repeats: true)
        }
        else {
            timer?.invalidate()
            timer = nil
            currentContentSizeHeight = 0
            timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(timerA), userInfo: nil, repeats: true)
        }
        
        var frame = adScrollView.frame
        frame.origin.x = 0
        
        let titleColor = UIColor(hexString: "#057aff")
        var index = 0
        for model in notices {
            
            frame.origin.y = CGFloat(index) * adScrollView.frame.height
            
            let titleLabel = UILabel(frame: frame)
            titleLabel.tag = index + 10
            // 富文本
            let attributed = NSMutableAttributedString()
            let titleAttri = NSAttributedString(string: "\(model.title): ", attributes: [NSForegroundColorAttributeName : titleColor ?? .black, NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16.0)])
            let subTitleAttri = NSAttributedString(string: "\(model.notice_title)", attributes: [NSForegroundColorAttributeName : UIColor.darkGray, NSFontAttributeName : UIFont.systemFont(ofSize: 14)])
            attributed.append(titleAttri)
            attributed.append(subTitleAttri)
            titleLabel.isUserInteractionEnabled = true
            titleLabel.addTapGesture(action: { (tap) in
                
                let tapIndex = titleLabel.tag - 10
                let tapModel = self.notices![tapIndex]
                self.delegate?.didClickNotice(notice: tapModel)
            })
            
            titleLabel.attributedText = attributed
            adScrollView.addSubview(titleLabel)
            
            index += 1
        }

        
    }

}
extension PreferentialModel {
    
    var title: String {
        return notice_type == "1" ? "系统消息" : "优惠消息"
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
        
        let selectedModel = models![indexPath.row]
        delegate?.didSelectedModel(model: selectedModel)
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

