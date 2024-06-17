//
//  MapView.swift
//  JRNL-SwiftUI_With_AppSchool
//
//  Created by 조성빈 on 5/29/24.
//

import SwiftUI
import MapKit
import CoreLocation

struct MapUIView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion
    @Binding var annotations: [MKAnnotation]
    @Binding var journalEntry: JournalEntry?
    @Binding var isDetailViewActive: Bool
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
        uiView.addAnnotations(annotations)
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapUIView
        
        init(_ parent: MapUIView) {
            self.parent = parent
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            return nil
        }
    }
}


struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    @State private var annotations: [MKAnnotation] = []
    @State private var journalEntry: JournalEntry?
    @State private var isDetailViewActive = false
    
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        NavigationStack {
            MapUIView(region: $region, annotations: $annotations, journalEntry: $journalEntry, isDetailViewActive: $isDetailViewActive)
                .onAppear {
                    locationManager.requestLocation()
                }
                .onReceive(locationManager.$location) { location in
                    if let location = location {
                        region = MKCoordinateRegion(center: location.coordinate,
                                                    span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
                        annotations = []
                    }
                }
                .navigationTitle("Map")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    MapView()
}
