//
//  MedicalProductDetailsEvaluationCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import EZSwiftExtensions
public protocol MedicalProductDetailsEvaluationCellDelegate {
    func didClickMore()
}

class MedicalProductDetailsEvaluationCell: UITableViewCell
{

    @IBOutlet weak var star1: UIImageView!
    
    @IBOutlet weak var star5: UIImageView!
    @IBOutlet weak var star4: UIImageView!
    @IBOutlet weak var star2: UIImageView!
    
    @IBOutlet weak var star3: UIImageView!
    
    var model: MedicalProductDetailsModel.Review? { didSet { updateUI() }}
    var mainModel: MedicalProductDetailsModel? {
        didSet {
            DispatchQueue.main.async {
                
                self.displayAllEvl.text = self.mainModel?.showReviewCount
            }
        }
    }
    
    fileprivate func updateUI() {
        
        guard let model = model else {
            return
        }
        DispatchQueue.main.async {
            self.displayUserName.text = model.user_name
            self.displayContent.text = model.content
            self.displayDate.text = model.showTime
            self.number = model.comment_rank
            self.userHeaderImageView.sd_setImage(with: model.headerURL, placeholderImage: Placeholder.DefaultImage)
        }
        
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
    
    var delegate: MedicalProductDetailsEvaluationCellDelegate?
    
    @IBOutlet weak var displayAllEvl: UILabel!
    @IBOutlet weak var userHeaderImageView: UIImageView!
   
    @IBOutlet weak var displayUserName: UILabel!

    @IBOutlet weak var displayContent: UILabel!
    
    @IBOutlet weak var displayDate: UILabel!
    
    @IBAction func more() {
        
        delegate?.didClickMore()
    }
    
    fileprivate var stars = [UIImageView]()
    override func awakeFromNib() {
        super.awakeFromNib()
        stars.append(star1)
        stars.append(star2)
        stars.append(star3)
        stars.append(star4)
        stars.append(star5)

    }
}
fileprivate extension MedicalProductDetailsModel {
    
    var showReviewCount: String {
        return "产品评价(\(review_count))"
    }
}

fileprivate extension MedicalProductDetailsModel.Review {
    
    var showTime: String? {
        
        return Date(fromString: add_time, format: "yyyyMMddHHmmss")?.toString(format: "yyyy-MM-dd")
    }
    
    var headerURL: URL {

        return URL(string: "\(host):\(8080)/\(objectAddress)\(face_image_url)")!
    }
}
