//
//  ProductEvaluationTableViewCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/31.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class ProductEvaluationTableViewCell: UITableViewCell
{

    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var displayContent: UILabel!
    @IBOutlet weak var displayDate: UILabel!
    
    @IBOutlet weak var star1: UIImageView!
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    @IBOutlet weak var star3: UIImageView!
    
    fileprivate var stars = [UIImageView]()
    var model: ProductEvalutaionModel? { didSet{ updateUI() } }
    
    fileprivate func updateUI() {
        
        if Thread.isMainThread {
            displayName.text = model?.user_name
            displayContent.text = model?.content
            displayDate.text = model?.showTime
            userImageView.sd_setImage(with: model!.imageURL, placeholderImage: Placeholder.DefaultImage)
            number = model?.comment_rank
        }
        
        else {
            
            DispatchQueue.main.async {
                
                self.displayName.text = self.model?.user_name
                self.displayContent.text = self.model?.content
                self.displayDate.text = self.model?.showTime
                self.userImageView.sd_setImage(with: self.model!.imageURL, placeholderImage: Placeholder.DefaultImage)
                self.number = self.model?.comment_rank
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        stars.append(star1)
        stars.append(star2)
        stars.append(star3)
        stars.append(star4)
        stars.append(star5)
        
    }
    
    fileprivate var number: String? {
        didSet {
            updateStar()
        }
    }
    fileprivate func updateStar() {
        
        if let number = number {
            
            for num in 0..<5 {
                
                stars[num].isHidden = num < number.toInt()! ? false : true
            }
        }
    }
}

fileprivate extension ProductEvalutaionModel {
    
    var imageURL: URL {
        let urlString = "\(host):\(8080)/\(objectAddress)\(face_image_url)"
        return URL(string: urlString)!
    }
    
    var showTime: String? {
        
        return Date(fromString: add_time, format: "yyyyMMddHHmmss")?.toString(format: "yyyy-MM-dd")
    }
}

