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
    fileprivate var customUserLocationView: MAAnnotationView!
    
    var models: [MedicalProductDetailsNearModel]? {
        didSet { updateUI() }
    }
    fileprivate var index = 0
    fileprivate func updateMapView() {
        
        mapView.zoomLevel = 14
        mapView.isShowsUserLocation = true
        mapView.userTrackingMode = MAUserTrackingMode.follow
        
        mapView.delegate = self
        mapView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
    }
    
    fileprivate enum ReuseIdentifier {
        static let AddPoint = "Add Point"
    }
    
    fileprivate func updateUI() {
        
        if models == nil { return }
        if models!.count == 0 { return }
                
        index = 0
        if mapView.annotations != nil {
            for annotation in mapView.annotations {
                if let annotation = annotation as? MAPointAnnotation {
                    mapView.removeAnnotation(annotation)
                }
            }
        }
        for model in models! {
            
            let pointAnnotation = MAPointAnnotation()
            pointAnnotation.title = model.cust_name
            pointAnnotation.subtitle = model.cust_address
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(Double(model.locations_lat)!, Double(model.locations_lng)!)
            mapView.addAnnotation(pointAnnotation)
        }
    }
    
}
extension MedicalProductDetailsNearModel {
    var imageURL: URL {
        let urlString = "\(host):\(picPort)/\(objectAddress)\(cust_avatar)"
        return URL(string: urlString)!
    }
}

// MARK: - MAMapViewDelegate
extension MedicalProductDetailsMapCell: MAMapViewDelegate {
    
    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.classForCoder()) {
            
            var pointAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ReuseIdentifier.AddPoint)
            if pointAnnotationView == nil {
                pointAnnotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: ReuseIdentifier.AddPoint)
            }
            
            pointAnnotationView?.frame = CGRect(x: 0, y: 0, w: 40, h: 40)
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, w: 40, h: 40))
            imageView.sd_setImage(with: models![index].imageURL, placeholderImage: Placeholder.DefaultImage)
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
