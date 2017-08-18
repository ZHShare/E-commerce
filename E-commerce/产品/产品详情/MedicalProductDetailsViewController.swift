//
//  MedicalProductDetailsViewController.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import DeckTransition

extension MedicalProductDetailsModel {
    
    var isCollection: Bool {
        return is_collection == "0" ? false : true
    }
}

fileprivate extension UIBarButtonItem {
    
    func isSelected() {
        
        DispatchQueue.main.async {
            self.image = UIImage(named: "product_details_is_fav")
        }
    }
    
    func isUnSelected() {
        DispatchQueue.main.async {
            self.image = UIImage(named: "product_details_fav")
        }
    }
}

class MedicalProductDetailsViewController: BaseTableViewController
{

    var productID: String?
    fileprivate var sectionOnes: [MedicalProductDetailsModel.SectionOne]?
    
    fileprivate var model: MedicalProductDetailsModel?
    fileprivate var nearCustomers: [MedicalProductDetailsNearModel]?
    fileprivate var currentTitle: String!
    var selectedTypeString: String?
    var selectedCount: String?
    fileprivate var footer: MedicalProductDetailsFooter!
    fileprivate var sectionHeader: MedicalProductDetailsBottomSectionHeader!
    
    fileprivate var imagesRowHeight: CGFloat = 0
    fileprivate var instaillRowHeight: CGFloat = 0
    fileprivate var paramsRowHeight: CGFloat = 0
    fileprivate var favoriteItem: UIBarButtonItem!
    fileprivate enum NavigationItem {
        static let title = "产品详情"
    }
    
    fileprivate enum ReuseIdentifier {
        static let mode = "Mode and Parameter"
        static let evaluation = "Evaluation"
        static let detailsImages = "Details Images"
        static let detailsMap = "Details Map"
        static let instaill = "Details Instaill"
        static let params = "Details Params"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        configTableView()
        configNavigationBar()
        fetchData()
        addNotice()
        DispatchQueue.global(qos: DispatchQoS.QoSClass.userInteractive).asyncAfter(deadline: DispatchTime.now()+0.5) { [unowned self] in
            self.fetchNearCustomers()
        }
    }
    
    fileprivate func setupUI() {
        
        currentTitle = CurrentTitle.details
        footer = MedicalProductDetailsFooter()
        sectionHeader = UIView.loadFromNibNamed(nibNamed: "MedicalProductDetailsBottomSectionHeader") as? MedicalProductDetailsBottomSectionHeader
    }
    
    deinit {
        removeNotice()
    }
    
    fileprivate func addNotice() {
        
        UserInfo.addObserver(observer: self, selector: #selector(notice(notice:)), notification: UserInfo.Notification.Update)
    }
    
    fileprivate func removeNotice() {
        
        UserInfo.removeObserver(observer: self, notification: UserInfo.Notification.Update)
    }
    
    @objc fileprivate func notice(notice: Notification) {
        
        fetchData()
    }
    
    fileprivate func fetchNearCustomers() {
        
        let params: [String: Any] = ["product_id": productID ?? ""]
        
        HomeNet.fetchDataWith(transCode: TransCode.Home.nearCustomer, params: params) { [unowned self](response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return self.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.nearCustomers = MedicalProductDetailsNearModel.models(withDic: response)
            
            if self.currentTitle == CurrentTitle.near {
                DispatchQueue.main.async { [unowned self] in
                    self.tableView.reloadSections(NSIndexSet(index: 2) as IndexSet, with: UITableViewRowAnimation.none)
                }
            }
        }
    }
    
    func fetchData() {
        
        let params: [String: Any] = ["product_id": productID ?? "",
                                     "user_id": LoginModel.load() == nil ? "" : LoginModel.load()!.user_id]
        HomeNet.fetchDataWith(transCode: TransCode.Home.productDetails, params: params) { [unowned self](response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return self.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.model = MedicalProductDetailsModel.model(withDic: response)
            (self.tableView.tableHeaderView as! MedicalProductDetailsHeader).model = self.model
            self.refreshFav()
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
    }
    
    fileprivate func refreshFav() {
        
        if model!.isCollection {
            favoriteItem.isSelected()
        }
        
        else {
            favoriteItem.isUnSelected()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let windows = UIApplication.shared.keyWindow!
        for sub in windows.subviews {
            if sub.isKind(of: MedicalProductDetailsFooter.classForCoder()) {
                return
            }
        }
        
        windows.addSubview(footer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        footer.removeFromSuperview()
    }

    fileprivate func configNavigationBar() {
        
        navigationItem.title = NavigationItem.title

        favoriteItem = UIBarButtonItem(image: UIImage(named: "product_details_fav"), style: UIBarButtonItemStyle.done, target: self, action: #selector(favorite))
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
        
        if selectedTypeString == nil {
            sectionOnes = MedicalProductDetailsModel.SectionOne.models()
        }
        else {
            sectionOnes = [MedicalProductDetailsModel.SectionOne(title: selectedTypeString!)]
        }
    }

    @objc fileprivate func favorite() {
     
        if LoginStatus.isLogined == false {
            return enterLogin()
        }
        
        guard let model = model else {
            return
        }
        
        if model.isCollection {
            // 取消
            collectionWithFlag(flag: "0", tip: "已取消收藏")
        }
        
        else {
            // 收藏
            collectionWithFlag(flag: "1", tip: "已收藏")
        }
        
    }
    
    fileprivate func collectionWithFlag(flag: String, tip: String) {
        
        // 成功后，改变当前model的收藏属性 并更新收藏按钮
        if flag == "0" {
            
            removeCollectionWithSuccessString(string: tip)
        }
        else {
            
            collectionWithSuccessString(string: tip)
            
        }
    }
    
    fileprivate func removeCollectionWithSuccessString(string: String) {
        
        let params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                     "product_id": model!.product_id]
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.removeFav, params: params){ [unowned self](response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return self.hudForWindowsWithMessage(msg: errorMsg)
            }
            self.model!.is_collection = "0"
            self.refreshFav()
            self.hudForWindowsWithMessage(msg: string)
        }
    }
    
    
    fileprivate func collectionWithSuccessString(string: String) {
        
        let params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                     "product_id": model!.product_id,
                                     "type": "1"]
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.addFav, params: params) { [unowned self](response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return self.hudForWindowsWithMessage(msg: errorMsg)
            }
            self.model!.is_collection = "1"
            self.refreshFav()
            self.hudForWindowsWithMessage(msg: string)
        }
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
            
            if let models = self.model?.reviews {
                return models.count
            }
            return 0
        }
        
        switch currentTitle {
        case CurrentTitle.details: return 1
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
            
            (cell as! MedicalProductDetailsEvaluationCell).model = model?.reviews?[indexPath.row]
            (cell as! MedicalProductDetailsEvaluationCell).mainModel = model
            (cell as! MedicalProductDetailsEvaluationCell).delegate = self
            return cell
        }
        
        if indexPath.section == 2 {
            
            
            switch currentTitle {
            case CurrentTitle.details:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.detailsImages, for: indexPath)
                
                if (cell as! MedicalProductDetailsImagesCell).product_id == nil {
                    (cell as! MedicalProductDetailsImagesCell).product_id = productID
                    (cell as! MedicalProductDetailsImagesCell).delegate = self
                }
                
                return cell
            case CurrentTitle.near:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.detailsMap, for: indexPath)
                (cell as! MedicalProductDetailsMapCell).models = nearCustomers
                return cell
            case CurrentTitle.params:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.params, for: indexPath)
                if (cell as! MedicalProductDetailsPramsCell).product_id == nil {
                    (cell as! MedicalProductDetailsPramsCell).product_id = productID
                    (cell as! MedicalProductDetailsPramsCell).delegate = self
                }
                return cell
            case CurrentTitle.setupIntro:
                let cell = tableView.dequeueReusableCell(withIdentifier: ReuseIdentifier.instaill, for: indexPath)
                if (cell as! MedicalProductDetailsInstallCell).product_id == nil {
                    
                    (cell as! MedicalProductDetailsInstallCell).product_id = productID
                    (cell as! MedicalProductDetailsInstallCell).delegate = self
                }
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 2 {
            
            switch currentTitle {
            case CurrentTitle.near:
                return UITableViewAutomaticDimension
            case CurrentTitle.params:
                return paramsRowHeight
            case CurrentTitle.details:
                return imagesRowHeight
            case CurrentTitle.setupIntro:
                return instaillRowHeight
            default:
                break
            }
            
            
        }
        
        return UITableViewAutomaticDimension
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
        
        if indexPath.section == 0 {
            
            let popViewController = ECStroryBoard.controller(type: MedicalProductDetailsPopViewController.self)
            let transitionDelegate = DeckTransitioningDelegate()
            transitionDelegate.isDismissEnabled = false
            popViewController.transitioningDelegate = transitionDelegate
            popViewController.modalPresentationStyle = .custom
            popViewController.model = model
            popViewController.selected = { [unowned self](type, count) in
                self.selectedTypeString = type
                self.selectedCount = count
                var newOnes = self.sectionOnes!
                newOnes[0].title = type
                self.sectionOnes = newOnes
                DispatchQueue.main.async {
                    
                    tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableViewRowAnimation.none)
                }
            }
            presentVC(popViewController)
        }
    }
    
}
// MARK: - MedicalProductDetailsImagesCellDelegate
extension MedicalProductDetailsViewController: MedicalProductDetailsImagesCellDelegate {
    
    func updateSection() {
        
        let sectionIndexSet = NSIndexSet(index: 2) as IndexSet
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadSections(sectionIndexSet, with: UITableViewRowAnimation.none)
        }
    }
    
    func imagesDidLoad(withHeight: CGFloat) {
        
        imagesRowHeight = withHeight
        updateSection()
    }
    
    func paramsDidLoad(withHeight: CGFloat) {
        
        paramsRowHeight = withHeight
        updateSection()
    }
    
    func intallsDidLoad(withHeight: CGFloat) {
        
        instaillRowHeight = withHeight
        updateSection()
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
        
        if LoginStatus.isLogined == false {
            enterLogin()
        }
        
        // 检查是否已经选择完产品参数 已选：调用加入购物车接口，加入并提示，未选：跳转选择参数，确定并加入和提示
        if selectedTypeString != nil {
            // 加入购物车
            addShoppingCarUpdate()
        }
        else {
         
            presentToPopParamsController(isUpdate: true)
        }
    }
    
    func ordding() {
        
        if LoginStatus.isLogined == false {
            enterLogin()
        }
        
        // 检查是否已经选择完产品参数 已选：带参跳转至结算页面，未选：跳转选择参数，确定完跳转至结算页面
        if selectedTypeString != nil {
            
            let shoppingModel = ShoppingModel(
                isSelected: false,
                product_name: model!.product_name,
                product_id: model!.product_id,
                goods_number: selectedCount!,
                sell_price: model!.sell_price,
                market_price: model!.market_price,
                product_image_url: model!.product_image_url,
                product_attr: selectedTypeString!)
            
            let sureShoppingViewController = ECStroryBoard.controller(type: SureShoppingViewController.self)
            sureShoppingViewController.selectedProducts = [shoppingModel]
            navigationController?.ecPushViewController(sureShoppingViewController)
        }
        
        else {
            presentToPopParamsController(isSureOrdding: { [unowned self] in
                
                let sureShoppingViewController = ECStroryBoard.controller(type: SureShoppingViewController.self)
                self.navigationController?.ecPushViewController(sureShoppingViewController)
            })
        }
    }
    
    fileprivate func presentToPopParamsController(isUpdate: Bool = false, isSureOrdding: (() -> Void)? = nil) {
        
        let popViewController = ECStroryBoard.controller(type: MedicalProductDetailsPopViewController.self)
        let transitionDelegate = DeckTransitioningDelegate()
        transitionDelegate.isDismissEnabled = false
        popViewController.transitioningDelegate = transitionDelegate
        popViewController.modalPresentationStyle = .custom
        popViewController.model = model
        popViewController.selected = { [unowned self](type, count) in
            
            self.selectedTypeString = type
            self.selectedCount = count
            
            var newOnes = self.sectionOnes!
            newOnes[0].title = type
            self.sectionOnes = newOnes
            
            if isUpdate {
                self.addShoppingCarUpdate()
            }
            if let sure = isSureOrdding {
                sure()
            }
            
            DispatchQueue.main.async {
                
                self.tableView.reloadSections(NSIndexSet(index: 0) as IndexSet, with: UITableViewRowAnimation.none)
            }
        }
        
        presentVC(popViewController)
    }
    
    
    fileprivate func addShoppingCarUpdate() {
        
        if LoginStatus.isLogined == false {
            return enterLogin()
        }
        
        let params: [String: Any] = ["user_id": LoginModel.load()!.user_id,
                                     "product_id": productID ?? "",
                                     "goods_number": selectedCount ?? "",
                                     "product_attr": selectedTypeString!]
        
        UserInfoNet.fetchDataWith(transCode: TransCode.UserInfo.addShoppingCar, params: params) { [unowned self](response, isLoadFaild, errorMsg) in
            
            if isLoadFaild {
                return self.hudForWindowsWithMessage(msg: errorMsg)
            }
            
            self.hudForWindowsWithMessage(msg: "已加入购物车")
        }
        
    }

    
}
// MARK: - MedicalProductDetailsEvaluationCellDelegate
extension MedicalProductDetailsViewController: MedicalProductDetailsEvaluationCellDelegate {
    
    func didClickMore() {
     
        let evaluationController = ECStroryBoard.controller(type: ProductEvaluationViewController.self)
        evaluationController.productID = productID ?? ""
        navigationController?.ecPushViewController(evaluationController)
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
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadSections(sectionIndexSet, with: UITableViewRowAnimation.none)
        }
    }
}
