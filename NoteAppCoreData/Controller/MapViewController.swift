//
//  MapViewController.swift
//  Rest API
//
//  Created by user192658 on 6/27/21.
//  Copyright © 2021 Niso. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    //Manager
    let manager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        manager.desiredAccuracy = kCLLocationAccuracyBest // Best location, more battery
        manager.delegate = self
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
    }

}

//Extension
extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            manager.stopUpdatingLocation()
            
            render(location)
        }
    }
    
    func render (_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        
        self.mapView.setRegion(region, animated: true)
        
        // Mark user location
        let pin = MKPointAnnotation()
        pin.title = "ME"
        pin.coordinate = coordinate
        self.mapView.addAnnotation(pin)
        
        // Mark near cinemas
        nearPlaces(region: region)
    }
    
    func nearPlaces(region: MKCoordinateRegion) {
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Cinema" // Place to find
        request.region = region
        
        let search = MKLocalSearch(request: request)
        search.start { (response, error) in
            guard let response = response else {
                print(error.debugDescription)
                return
            }
            for item in response.mapItems {
                let pin = MKPointAnnotation()
                pin.coordinate = item.placemark.coordinate
                pin.title = item.name
                DispatchQueue.main.async {
                    self.mapView.addAnnotation(pin)
                }
            }
        }
    }
    
}
