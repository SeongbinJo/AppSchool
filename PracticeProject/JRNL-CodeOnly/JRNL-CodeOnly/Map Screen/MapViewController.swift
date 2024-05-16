//
//  MapViewController.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    private lazy var mapView: MKMapView = {
       let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationItem.title = "Map"
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer // 위치 정보를 1Km 단위로 끊는다.
        
        mapView.delegate = self

        view.addSubview(mapView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            mapView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor)
        ])
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        locationManager.requestLocation() // 현위치 정보 요청
    }
    
    func setInitialRegion(lat: CLLocationDegrees, long: CLLocationDegrees) -> MKCoordinateRegion {
        // MKCoordinatRegion 타입은 특정 영역을 나타냄
        // center: 위도, 경도를 담아냄, span: 영역의 크기를 나타냄
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        return region
    }

}

extension MapViewController: CLLocationManagerDelegate {
    // 위치 정보 업데이트 되었을 때
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myLocation = locations.first {
            let lat = myLocation.coordinate.latitude
            let long = myLocation.coordinate.longitude
            mapView.region = setInitialRegion(lat: lat, long: long)
            print(lat)
            print(long)
            mapView.addAnnotations(SharedData.shared.getAllJournalEntries())
        }
    }
    
    // 위치 정보 읽기 실패했을 때
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        fatalError("Failed to find user's location: \(error.localizedDescription)")
    }
}


extension MapViewController: MKMapViewDelegate {
    // didSelected가 클릭시 액션을 부여한다면 viewFor는 핀을 눌렀을때, 나타날 annotationView를 보여준다.
    func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
        let identifier = "mapAnnotation"
        if annotation is JournalEntry {
            if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
                annotationView.annotation = annotation
                return annotationView
            }else {
                let annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true // 눌렀을때 불러줄까?
                let callOutButton = UIButton(type: .detailDisclosure)
                annotationView.leftCalloutAccessoryView = callOutButton
                return annotationView
            }
        }
        return nil
    }
}
