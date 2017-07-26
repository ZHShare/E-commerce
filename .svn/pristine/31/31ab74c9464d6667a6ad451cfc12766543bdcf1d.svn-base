//
//  XHScrollView.swift
//  XHScrollView
//
//  Created by 王雄皓 on 2016/11/30.
//  Copyright © 2016年 王雄皓. All rights reserved.
//

import UIKit
import SDWebImage

protocol XHScrollViewDelegate: NSObjectProtocol {
    
    func selected(_ index: NSInteger)
}

enum UIPageControlStyle {
    case none    // default is none
    case left    // left
    case center  // center
    case right   // right
}

class XHScrollView: UIView {
    
    fileprivate var timer: Timer!
    fileprivate lazy var xscrollView = UIScrollView()
    fileprivate lazy var pageControl = UIPageControl()
    
    var dataArray:[String]? { // 数据源数组(一般传模型对象数组)
        didSet{ // 设置完成后调用
            
            guard let datas = dataArray else {
                return loadDefaultImage()
            }
            
            if datas.count <= 1 {
                return loadDefaultImage()
            }
            
            xscrollView.isScrollEnabled = true
            leftImageIndex = datas.count-1
            centerImageIndex = 0
            rightImageIndex = 1
            
            if datas.first!.contains("http") {
               
                leftImageView!.sd_setImage(with: URL.init(string: dataArray![leftImageIndex]))
                centerImageView!.sd_setImage(with: URL.init(string: dataArray![centerImageIndex]))
                rightImageView!.sd_setImage(with: URL.init(string: dataArray![rightImageIndex]))
            }
            if isNeedTimer {
                startTime()
            }
            pageControl.numberOfPages = dataArray!.count
            pageControl.pageIndicatorTintColor = UIColor.gray
            pageControl.currentPageIndicatorTintColor = UIColor.white
            if pageControlShowStyle == .none {
                pageControl.isHidden = true
                return
            }
            var pageX:CGFloat = 0
            let pageWidth = CGFloat(20 * dataArray!.count)
            switch pageControlShowStyle {
            case .left:
                pageX = 10
            case .center:
                pageX = (frame.size.width-CGFloat(20*dataArray!.count))/2
            case .right:
                pageX = frame.size.width - CGFloat(10) - pageWidth
            default:
                break
            }
            pageControl.frame = CGRect(x: pageX, y: frame.size.height-CGFloat(35), width: pageWidth, height: 20)
            pageControl.isHidden = false
            
        }
    }
    var isNeedTimer = true // 是否需要自动滚动
    var pageControlShowStyle:UIPageControlStyle = .none // 默认值
    var placeHoldImage:UIImage? { // 可选型变量默认图片
        didSet{
            if placeHoldImage != nil {
                centerImageView?.image = placeHoldImage
                xscrollView.isScrollEnabled = false
            }
        }
    }
    var adMoveTime:CGFloat = 3 // 广告轮播时间
    var selected:((_ index: NSInteger) -> ())? // 点击回调，参数是点击的索引值
    weak var delegate:XHScrollViewDelegate?    // 广告点击的代理
    fileprivate var leftImageView:UIImageView?   // 私有型变量左侧图片
    fileprivate var centerImageView:UIImageView? // 私有型变量中间图片
    fileprivate var rightImageView:UIImageView?  // 私有型变量右侧图片
    fileprivate var leftImageIndex:NSInteger = 0 // 私有型变量左侧图片索引
    fileprivate var centerImageIndex:NSInteger = 0 // 私有型变量当前图片索引
    fileprivate var rightImageIndex:NSInteger = 0  // 私有型变量右侧图片索引
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let w = frame.size.width
        let h = frame.size.height
        xscrollView.frame = frame
        xscrollView.bounces = false
        xscrollView.showsHorizontalScrollIndicator = false
        xscrollView.showsVerticalScrollIndicator = false
        xscrollView.isPagingEnabled = true
        xscrollView.contentOffset = CGPoint(x: w, y: 0)
        xscrollView.contentSize = CGSize(width: w*3, height: h)
        xscrollView.delegate = self
        addSubview(xscrollView)
        
        leftImageView = UIImageView(frame: frame)
        xscrollView.addSubview(leftImageView!)
        centerImageView = UIImageView(frame: CGRect(x: w, y: 0, width: w, height: h))
        centerImageView?.isUserInteractionEnabled = true
        centerImageView?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapClick)))
        xscrollView.addSubview(centerImageView!)
        rightImageView = UIImageView(frame: CGRect(x: w*2, y: 0, width: w, height: h))
        xscrollView.addSubview(rightImageView!)
        addSubview(pageControl)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func tapClick(){
        selected?(centerImageIndex)
        delegate?.selected(centerImageIndex)
    }
    
    func loadFirstIndex() {
        
        xscrollView.isScrollEnabled = false
        if dataArray?.count == 1 {
            centerImageIndex = 0
            if let url = dataArray?.first {
                centerImageView?.sd_setImage(with: URL.init(string: url), placeholderImage: placeHoldImage!)
            }
        }
    }
    
    func loadDefaultImage() {
        
        xscrollView.isScrollEnabled = false
        if dataArray?.count == 1 {
            centerImageIndex = 0
            centerImageView?.image = UIImage(named: dataArray![centerImageIndex])
        }
    }
    
}

// MARK: - 开启/暂停/重新开始/停止定时器
extension XHScrollView{
  
    func startTime()
    {
        if timer != nil
        {
            stopTime()
        }
        else
        {
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(adMoveTime), target: self, selector: #selector(startLoopScroll), userInfo: nil, repeats: true)
        }
    }
   
    func pauseTime() {
        
        guard let ti = timer else {
            return
        }
        
        ti.fireDate = Date.distantFuture
    }
 
    func replayTime() {
        
        guard let ti = timer else {
            return
        }
        
        ti.fireDate = Date(timeIntervalSinceNow: TimeInterval(adMoveTime))
    }
   
    func stopTime()
    {
        
        guard let ti = timer else {
            return
        }
        
        ti.invalidate()
        timer = nil
    }
}
// MARK: - 开始循环滚动
extension XHScrollView{
    
    @objc func startLoopScroll() {
        xscrollView.setContentOffset(CGPoint(x: frame.size.width*2, y: 0), animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: ({
            self.perform(#selector(self.scrollViewDidEndDecelerating), with: self.xscrollView)
        }))
    }
}
// MARK: - scrollView的代理方法
extension XHScrollView: UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        pauseTime()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        replayTime()
    } 
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { 
       
        if scrollView.contentOffset.x == 0 {
            centerImageIndex = centerImageIndex-1 
            leftImageIndex = leftImageIndex-1 
            rightImageIndex = rightImageIndex-1 
            if leftImageIndex == -1 { 
                leftImageIndex = dataArray!.count-1 
            } 
            if centerImageIndex == -1 { 
                centerImageIndex = dataArray!.count-1 
            } 
            if rightImageIndex == -1 { 
                rightImageIndex = dataArray!.count-1 
            } 
        } 
        else if scrollView.contentOffset.x == frame.size.width*2 { 
           
            centerImageIndex = centerImageIndex+1
            leftImageIndex = leftImageIndex+1 
            rightImageIndex = rightImageIndex+1 
            if leftImageIndex == dataArray!.count { 
                leftImageIndex = 0 
            } 
            if centerImageIndex == dataArray!.count { 
                centerImageIndex = 0 
            } 
            if rightImageIndex == dataArray!.count { 
                rightImageIndex = 0 
            } 
        } 
        else{ 
            return 
        }
        
        leftImageView!.sd_setImage(with: URL.init(string: dataArray![leftImageIndex]))
        centerImageView!.sd_setImage(with: URL.init(string: dataArray![centerImageIndex]))
        rightImageView!.sd_setImage(with: URL.init(string: dataArray![rightImageIndex]))
        pageControl.currentPage = centerImageIndex
        scrollView.setContentOffset(CGPoint(x: frame.size.width, y: 0), animated: false) 
    } 
}

