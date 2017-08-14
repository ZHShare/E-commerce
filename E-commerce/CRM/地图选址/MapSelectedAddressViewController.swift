//
//  MapSelectedAddressViewController.swift
//  E-commerce
//
//  Created by YE on 2017/8/14.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit

struct MapAddress {
    
    let address: String
    let latitude: String
    let longitude: String
}

class MapSelectedAddressViewController: BaseViewController
{

    var address: ((MapAddress) -> Void)?
    @IBAction func sure() {
        if let address = address {
            let add = MapAddress(address: displayAddressText ?? "", latitude: latitude, longitude: longitude)
            address(add)
            popVC()
        }
    }
    @IBOutlet weak var displayAddress: UIButton!
    @IBOutlet weak var mapView: MAMapView!
    
    fileprivate var latitude: String = ""
    fileprivate var longitude: String = ""
    fileprivate let resultController = ECStroryBoard.controller(type: AddressListViewController.self)
    fileprivate var searchController: UISearchController!
    
    fileprivate var customUserLocationView: MAAnnotationView!
    fileprivate var pointAnnotation: MAPointAnnotation!
    
    fileprivate var regeo: AMapReGeocodeSearchRequest!
    
    fileprivate var search: AMapSearchAPI!
    
    fileprivate var displayAddressText: String? {
        
        get { return displayAddress.currentTitle }
        set {
            displayAddress.setTitle(newValue, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configMapView()
        configSearchController()
    }

    fileprivate func configSearchController() {
        
        searchController = UISearchController(searchResultsController: resultController)
        searchController.delegate = resultController
        searchController.searchResultsUpdater = resultController
        
        searchController.searchBar.barTintColor = UIColor.groupTableViewBackground
        searchController.searchBar.placeholder = "搜索地址"
        searchController.disablesAutomaticKeyboardDismissal = false
        searchController.dimsBackgroundDuringPresentation = true
        
        
        let titleView = UIView(frame: CGRect.init(x: 0, y: 0, w: Screen.width-100, h: self.navBar!.frame.size.height))
        titleView.backgroundColor = .white
        searchController.searchBar.frame = CGRect(origin: CGPoint.zero, size: titleView.frame.size)
        titleView.addSubview(searchController.searchBar)
        definesPresentationContext = true
        
        // 取消按钮文字
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "取消"

        titleView.isUserInteractionEnabled = true
        navigationItem.titleView = titleView
    }
    
    
    fileprivate func configMapView() {
        
        mapView.isShowsUserLocation = false
        mapView.userTrackingMode = MAUserTrackingMode.follow
        mapView.showsScale = false
        mapView.delegate = self
        mapView.autoresizingMask = [UIViewAutoresizing.flexibleHeight, UIViewAutoresizing.flexibleWidth]
        
        regeo = AMapReGeocodeSearchRequest()
        regeo.requireExtension = true
        
        search = AMapSearchAPI()
        search.delegate = self
    }
    
    fileprivate enum ReuseIdentifier {
        static let Center = "Center"
    }
   
  
}

// MARK: - AMapSearchDelegate
extension MapSelectedAddressViewController: AMapSearchDelegate {
    
    func onReGeocodeSearchDone(_ request: AMapReGeocodeSearchRequest!, response: AMapReGeocodeSearchResponse!) {
        
        if response.regeocode != nil {
            
            let reocode = response.regeocode
            print(reocode?.addressComponent.adcode,reocode?.addressComponent.city)
            let province = reocode?.addressComponent.province ?? ""
            let city = reocode?.addressComponent.city ?? ""
            let township = reocode?.addressComponent.township ?? ""
            let street = reocode?.addressComponent.streetNumber?.street ?? ""
            let streetNumber = reocode?.addressComponent.streetNumber?.number ?? ""
        
            latitude = "\(request.location.latitude)"
            longitude = "\(request.location.longitude)"
            UIView.animate(withDuration: 0.3, animations: { 
                
                self.displayAddressText = "\(province) \(city) \(township) \(street)\(streetNumber)"
            }, completion: nil)
        }
    }
    
    
}

// MARK: - MAMapViewDelegate
extension MapSelectedAddressViewController: MAMapViewDelegate {
    
    func mapView(_ mapView: MAMapView!, regionDidChangeAnimated animated: Bool) {
    
        regeo.location = AMapGeoPoint.location(withLatitude: CGFloat(mapView.centerCoordinate.latitude), longitude: CGFloat(mapView.centerCoordinate.longitude))
        search.aMapReGoecodeSearch(regeo)
    }
    
    func mapView(_ mapView: MAMapView!, regionWillChangeAnimated animated: Bool) {
        
        pointAnnotation?.coordinate = mapView.centerCoordinate
    }

    func mapView(_ mapView: MAMapView!, viewFor annotation: MAAnnotation!) -> MAAnnotationView! {
        
        if annotation.isKind(of: MAPointAnnotation.classForCoder()) {
            
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: ReuseIdentifier.Center)
            if annotationView == nil {
                annotationView = MAAnnotationView(annotation: annotation, reuseIdentifier: ReuseIdentifier.Center)
            }
            
            annotationView?.image = UIImage(named: "userPosition")
            annotationView?.centerOffset = CGPoint(x: 0, y: -18)
            return annotationView
        }
        
        return nil
    }
    
    
    func mapView(_ mapView:MAMapView!, didUpdate userLocation: MAUserLocation!, updatingLocation:Bool ) {
        if(!updatingLocation) {
            
            if pointAnnotation == nil {
                pointAnnotation = MAPointAnnotation()
                mapView.addAnnotation(pointAnnotation)
            }
            
            pointAnnotation.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)
            UIView.animate(withDuration: 0.1, animations: {
               
                mapView.setCenter(self.pointAnnotation.coordinate, animated: true)
                mapView.setZoomLevel(16.1, animated: true)
            })
        }
    }
}
