//
//  MedicalProductDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductDetailsViewController: BaseTableViewController
{

    fileprivate var sectionOnes: [MedicalProductDetailsModel.SectionOne]?
    fileprivate var sectionTwos: [MedicalProductDetailsModel.SectionTwo]?
    
    fileprivate var currentTitle = CurrentTitle.details
    fileprivate let footer = MedicalProductDetailsFooter()
    fileprivate let sectionHeader: MedicalProductDetailsBottomSectionHeader? = UIView.loadFromNibNamed(nibNamed: "MedicalProductDetailsBottomSectionHeader") as? MedicalProductDetailsBottomSectionHeader
    
    fileprivate enum NavigationItem {
        static let title = "产品详情"
    }
    
    fileprivate enum ReuseIdentifier {
        static let mode = "Mode and Parameter"
        static let evaluation = "Evaluation"
        static let detailsImages = "Details Images"
        static let detailsMap = "Details Map"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        configNavigationBar()
        fetchData()
    }
    
    fileprivate func fetchData() {
        
        sectionOnes = MedicalProductDetailsModel.SectionOne.models()
        sectionTwos = MedicalProductDetailsModel.SectionTwo.models()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let windows = UIApplication.shared.keyWindow!
        if windows.subviews.contains(footer) {
            return
        }
        
        windows.addSubview(footer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        footer.removeFromSuperview()
    }

    fileprivate func configNavigationBar() {
        
        navigationItem.title = NavigationItem.title

        let favoriteItem = UIBarButtonItem(image: UIImage(named: "product_details_fav"), style: UIBarButtonItemStyle.done, target: self, action: #selector(favorite))
        favoriteItem.tintColor = UIColor.black
        navigationItem.rightBarButtonItem = favoriteItem
    }
    
    fileprivate func configTableView() {
        
        let tableHeader = tableView.tableHeaderView
        (tableHeader as! MedicalProductDetailsHeader).delegate = self
        
        footer.delegate = self
        
        sectionHeader?.delegate = self
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    @objc fileprivate func favorite() {
        
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        if section == 0 {
            
            if let models = sectionOnes {
                return models.count
            }
            return 0
        }
        
        else if section == 1 {
            
            if let models = sectionTwos {
                return models.count
            }
            return 0
        }
        
        switch currentTitle {
        case CurrentTitle.details: return 10
        case CurrentTitle.near: return 1
        case CurrentTitle.params: return 1
        case CurrentTitle.setupIntro: return 1
        default:
            return 0
        }
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
           let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.mode, for: indexPath)
            
            (cell as! MedicalProductDetailsModeCell).model = sectionOnes?[indexPath.row]
            
            return cell
        }
        
        if indexPath.section == 1 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.evaluation, for: indexPath)
            
            (cell as! MedicalProductDetailsEvaluationCell).model = sectionTwos?[indexPath.row]
            
            return cell
        }
        
        if indexPath.section == 2 {
            
            
            switch currentTitle {
            case CurrentTitle.details:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.detailsImages, for: indexPath)
                return cell
            case CurrentTitle.near:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.detailsMap, for: indexPath)
                return cell
            case CurrentTitle.params:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.mode, for: indexPath)
                return cell
            case CurrentTitle.setupIntro:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.evaluation, for: indexPath)
                return cell
            default:
                return UITableViewCell()
            }
        }


        return UITableViewCell()
    }
 
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 2 {
            return sectionHeader
        }
        
        return UIView()
        
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 2 {
            return 40
        }
        
        return 0.001
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

// MARK: - MedicalProductDetailsHeaderDelegate
extension MedicalProductDetailsViewController: MedicalProductDetailsHeaderDelegate {
    
    func priceClick() {
        
        if LoginStatus.isLogined == false { enterLogin() }

    }
    
    func share() {
        
        if LoginStatus.isLogined == false { enterLogin() }
    }

}
// MARK: - MedicalProductDetailsFooterDelegate
extension MedicalProductDetailsViewController: MedicalProductDetailsFooterDelegate {
    
    func customerService() {
        if LoginStatus.isLogined == false { enterLogin() }
    }
    
    func addShoppingCar() {
        if LoginStatus.isLogined == false { enterLogin() }
    }
    
    func ordding() {
        if LoginStatus.isLogined == false { enterLogin() }
    }
    
}
// MARK: - MedicalProductDetailsEvaluationCellDelegate
extension MedicalProductDetailsViewController: MedicalProductDetailsEvaluationCellDelegate {
    
    func didClickMore() {
        
        if LoginStatus.isLogined == false { enterLogin() }

    }
}
// MARK: - MedicalProductDetailsBottomSectionHeaderDelegate
extension MedicalProductDetailsViewController: MedicalProductDetailsBottomSectionHeaderDelegate {
    
    fileprivate enum CurrentTitle {
        static let details = "图文详情"
        static let params = "产品参数"
        static let setupIntro = "安装介绍"
        static let near = "附近客户"
    }
    
    func didClick(sender: UIButton) {
        
        let sectionIndexSet = NSIndexSet(index: 2) as IndexSet
        
        currentTitle = sender.currentTitle!
        print("\(sender.currentTitle!)")
        DispatchQueue.main.async {
            self.tableView.reloadSections(sectionIndexSet, with: UITableViewRowAnimation.none)
        }
    }
}
