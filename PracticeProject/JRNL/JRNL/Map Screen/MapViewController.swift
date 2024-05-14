//
//  MapViewController.swift
//  JRNL
//
//  Created by 조성빈 on 5/14/24.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController {
    
    @IBOutlet var mapView: MKMapView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        
        self.navigationItem.title = "Loading..."
    }
    
    
    //MARK: - Methods
    func setInitialRegion(lat: CLLocationDegrees, long: CLLocationDegrees) -> MKCoordinateRegion {
        // 0.01 두개는 범위 설정임.
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
    }
}


extension MapViewController: CLLocationManagerDelegate {
    //MARK: - CLLocationManagerDelegate Function
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myLocation = locations.first {
            let lat = myLocation.coordinate.latitude
            let long = myLocation.coordinate.longitude
            self.navigationItem.title = "Loaded Map"
            mapView.region = setInitialRegion(lat: lat, long: long)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}
