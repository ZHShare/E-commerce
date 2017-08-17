//
//  NearMapViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/15.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
class NearMapViewController: BaseViewController
{

    @IBOutlet weak var mapView: MAMapView! { didSet { updateMapView() } }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    var customUserLocationView: MAAnnotationView!
    
    
    fileprivate func updateMapView() {
        
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        
        mapView.delegate = self
        mapView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let pointAnnotation = MAPointAnnotation()
        pointAnnotation.coordinate = CLLocationCoordinate2DMake(28.2202209729254, 112.894838088646)
        pointAnnotation.title = "湖南星豪网络科技有限公司"
        pointAnnotation.subtitle = "专注 科技 创新"
        mapView.addAnnotation(pointAnnotation)
        
    }
    
    fileprivate enum ReuseIdentifier {
        static let AddPoint = "Add Point"
    }
}
// MARK: - MAMapViewDelegate
extension NearMapViewController: MAMapViewDelegate {
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        
        if annotation.isKind(of: MAPointAnnotation.classForCoder()) {
            
            var pointAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ReuseIdentifier.AddPoint)
            if pointAnnotationView == nil {
                pointAnnotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: ReuseIdentifier.AddPoint)
            }
            
            pointAnnotationView?.frame = CGRect(x: 0, y: 0, w: 40, h: 40)
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, w: 40, h: 40))
            imageView.image = UIImage(named: "userPosition")
            imageView.layer.cornerRadius = imageView.bounds.width / 2
            imageView.layer.masksToBounds = true
            pointAnnotationView?.addSubview(imageView)
            pointAnnotationView?.layer.borderColor = UIColor.white.cgColor
            pointAnnotationView?.layer.borderWidth = 2
            pointAnnotationView?.layer.cornerRadius = 20
            pointAnnotationView?.canShowCallout = true
           
            return pointAnnotationView
        }
        
        return nil
    }
    
    
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        
        let annoationview = views.first as! MAAnnotationView
        
        if(annoationview.annotation .isKind(of: MAUserLocation.self)) {
            let rprt = MAUserLocationRepresentation.init()
            rprt.fillColor = UIColor.red.withAlphaComponent(0.4)
            rprt.strokeColor = UIColor.gray
            rprt.image = UIImage(named: "userPosition")
            rprt.lineWidth = 3
            
            mapView.update(rprt)
            
            annoationview.calloutOffset = CGPoint.init(x: 0, y: 0)
            annoationview.canShowCallout = false
            self.customUserLocationView = annoationview
        }
        
    }
    
    func mapView(_ mapView:MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation:Bool ) {
        if(!updatingLocation && self.customUserLocationView != nil) {
            UIView.animate(withDuration: 0.1, animations: {
                let degree = userLocation.heading.trueHeading
                let radian = (degree * M_PI) / 180.0
                self.customUserLocationView.transform = CGAffineTransform.init(rotationAngle: CGFloat(radian))
            })
        }
    }
}
