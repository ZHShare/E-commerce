//
//  MedicalProductDetailsMapCell.swift
//  E-commerce
//
//  Created by YE on 2017/7/27.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

class MedicalProductDetailsMapCell: UITableViewCell
{

    @IBOutlet var mapView: MAMapView! { didSet { updateMapView() } }
    var customUserLocationView: MAAnnotationView!

    
    fileprivate func updateMapView() {
        
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        
        mapView.delegate = self
        mapView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
    }
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        frame.size = CGSize(width: Screen.width, height: Screen.height * ( 2 / 3))
//        mapView.frame.size = frame.size
//    }
    
}
// MARK: - MAMapViewDelegate
extension MedicalProductDetailsMapCell: MAMapViewDelegate {
    
    func mapView(_ mapView: MAMapView!, didAddAnnotationViews views: [Any]!) {
        
        let annoationview = views.first as! MAAnnotationView
        
        if(annoationview.annotation .isKind(of: MAUserLocation.self)) {
            let rprt = MAUserLocationRepresentation.init()
            rprt.fillColor = UIColor.red.withAlphaComponent(0.4)
            rprt.strokeColor = UIColor.gray
            rprt.image = UIImage.init(named: "userPosition")
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
