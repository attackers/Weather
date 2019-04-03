//
//  LocationManager.swift
//  Weather
//
//  Created by ZZCM on 2019/4/3.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import CoreLocation

class LocationManager: NSObject {
    let locationManager = CLLocationManager()
    var locationBlock:((String,CLLocationCoordinate2D) -> Void)?
    let geocoder = CLGeocoder()
    override init() {
        super.init()
        locationManager.delegate = self
        setupLocation()
    }
    func getLocationStatus() ->  CLAuthorizationStatus{
        return CLLocationManager.authorizationStatus()
    }
    func cityToLocationCoordinate2D(city: String,coordinate: @escaping (CLLocationCoordinate2D) -> Void){
        geocoder.geocodeAddressString(city) { placemarks, error in
            coordinate((placemarks?.first?.location!.coordinate)!)
        }
    }
    func setupLocation() {
        let status = getLocationStatus()
        switch status {
        case .authorizedAlways,.authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied,.restricted:
            if self.locationBlock != nil {
                self.locationBlock!("定位失败", CLLocationCoordinate2D())
            }
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}
extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidPauseLocationUpdates(_ manager: CLLocationManager) {
        print(getLocationStatus)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        manager.stopUpdatingLocation()
        let geocoder =  CLGeocoder()
        
        geocoder.reverseGeocodeLocation(locations.first!) { (placemark, error) in
            if placemark != nil {
                let locationPlacemark = placemark?.first
    
                if self.locationBlock != nil {
                    self.locationBlock!((locationPlacemark?.locality)!, (locationPlacemark?.location!.coordinate)!)
                }
            }
        }
    }
}
