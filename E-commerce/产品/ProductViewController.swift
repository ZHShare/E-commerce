//
//  ProductViewController.swift
//  E-commerce
//
//  Created by 王雄皓 on 2017/7/19.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

public enum Screen {
    static let width = UIScreen.main.bounds.width
    static let height = UIScreen.main.bounds.height
}

class ProductViewController: BaseViewController
{

    enum ReuseIdentifier {
        static let first = "Buttons ScrollView"
        static let system = "System Device"
    }
    
    enum Nib {
        static let first: UINib = UINib(nibName: "ProductFirstTableViewCell", bundle: nil)
        static let system: UINib = UINib(nibName: "ProductSystemTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var tableView: UITableView! { didSet { configTableView() } }
    @IBOutlet weak var navgationBarView: UIView!
    @IBOutlet weak var navigationBarBg: UIView!
    
    fileprivate lazy var tableHeader: XHScrollView = {
       
        let header = XHScrollView(frame: CGRect(x: 0, y: 0, width: Screen.width, height: 200))
        header.placeHoldImage = UIImage(named: "product_ad_default")!.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return header
    }()
    
    fileprivate func configTableView() {
        
        tableView.tableHeaderView = tableHeader
        
        tableView.register(Nib.first, forCellReuseIdentifier: ReuseIdentifier.first)
        tableView.register(Nib.system, forCellReuseIdentifier: ReuseIdentifier.system)
    }
    
    @IBAction func search() {
        
        print("search product")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        loadData()
    }

    
}

// MARK: - File private 
fileprivate extension ProductViewController {
    
    // Setup UI
    func setupUI() {
        
       
    }
    
    func loadData() {
        
        
    }
}

// MARK: - UITableViewDelegate UITableViewDataSource
extension ProductViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.first) as? ProductFirstTableViewCell {
                
                return cell
            }
        }
        
        else if indexPath.section == 1 {
            
            if let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.system) as? ProductSystemTableViewCell {
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 250
        }
        
        else if indexPath.section == 1 {
            return 215.5
        }
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 1 {
            
            let systemHeader = UIView.loadFromNibNamed(nibNamed: "ProductHeader") as! ProductHeader
            systemHeader.displayTitle.text = "系统套餐"
            return systemHeader
        }
        
        else if section == 2 {
            
             let systemHeader = UIView.loadFromNibNamed(nibNamed: "ProductHeader") as! ProductHeader
            systemHeader.displayTitle.text = "产品列表"
            return systemHeader
        }
        
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 1 || section == 2 {
            return 30
        }
        
        return 0.001
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.001
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let contentOffsetY = scrollView.contentOffset.y
        
        if contentOffsetY > 64 {
            navigationBarBg.alpha = 1
        }
        
        else if contentOffsetY < 0 {
            navigationBarBg.alpha = 0
        }
        
        else {
            
            let alpha = contentOffsetY / 64
            UIView.animate(withDuration: 0.5, animations: { 
                
                self.navigationBarBg.alpha = alpha
            }, completion: nil)
        }
        
    }
}

// MARK: - How to initialise a UIView Class with a xib file in Swift
extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle : Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}

