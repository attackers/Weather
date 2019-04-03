//
//  AddressViewController.swift
//  Weather
//
//  Created by ZZCM on 2019/3/27.
//  Copyright © 2019 ZZCM. All rights reserved.
//

import UIKit
import MapKit
class AddressViewController: UIViewController {
    var location: CLLocationCoordinate2D?
    let lManager = LocationManager()
    @IBOutlet weak var mapview: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override  func viewDidLoad() {
        super.viewDidLoad()
        
        mapview.mapType = .standard
        mapview.userTrackingMode = .followWithHeading
        mapview.delegate = self
        searchBar.delegate = self
        mapview.isZoomEnabled = true
        
    }
    @IBAction func backItem(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)

    }
}
extension AddressViewController: MKMapViewDelegate,UISearchBarDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        mapview.setCenter(self.location!, animated: true)
        var region = mapview.region
        region.span.latitudeDelta =  0.01
        region.span.longitudeDelta =  0.01
        region.center  = self.location!
        mapview.setRegion(region, animated: true)
        mapView.showsUserLocation = true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        lManager.cityToLocationCoordinate2D(city: searchBar.text! as String) { coordinate2D in
            DispatchQueue.main.async {
                self.location = coordinate2D
                var region = self.mapview.region
                region.span.latitudeDelta =  0.01
                region.span.longitudeDelta = 0.01
                region.center  = self.location!
                self.mapview.setRegion(region, animated: true)

            }
        }
    }

}
