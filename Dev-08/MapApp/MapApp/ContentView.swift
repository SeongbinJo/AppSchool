//
//  ContentView.swift
//  MapApp
//
//  Created by 조성빈 on 7/4/24.
//

import SwiftUI
import MapKit

extension CLLocationCoordinate2D {
    static let paris = CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222)
}

struct ContentView: View {
    let locationManager = CLLocationManager()
    
    @State var message = "Map of Paris"
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: .paris, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
    @State private var position: MapCameraPosition = .region(MKCoordinateRegion(center: .paris, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)))
    
    var body: some View {
        VStack {
            
            // 기존의 map 사용방식
//            Map(coordinateRegion: $region)
//                .mapStyle(.hybrid)
            
            // 새로운 map 사용방식
            Map(position: $position) {
                Annotation("에펠탑", coordinate: .paris) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(.purple)
                        .background(.white)
                        .clipShape(Circle())
                }
            }
            TextEditor(text: $message)
                .frame(width: .infinity, height: 100)
        }
        .onAppear {
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.distanceFilter = kCLDistanceFilterNone
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
        }
    }
}

#Preview {
    ContentView()
}
