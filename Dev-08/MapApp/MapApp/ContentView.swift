//
//  ContentView.swift
//  MapApp
//
//  Created by 조성빈 on 7/4/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    let locationManager = CLLocationManager()
    
    @State var message = "Map of Paris"
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 48.856613, longitude: 2.352222), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))

    
    var body: some View {
        VStack {
            Map(coordinateRegion: $region)
                .mapStyle(.hybrid)
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
