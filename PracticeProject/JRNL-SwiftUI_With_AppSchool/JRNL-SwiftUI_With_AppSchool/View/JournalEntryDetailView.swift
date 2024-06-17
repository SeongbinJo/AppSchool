//
//  JournalEntryDetailView.swift
//  JRNL-SwiftUI_With_AppSchool
//
//  Created by 조성빈 on 5/29/24.
//

import SwiftUI
import MapKit

struct JournalEntryDetailView: View {
    var journalEntry: JournalEntry
    @State private var mapImage: UIImage?
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: 30)
                
                Text(journalEntry.date.formatted(.dateTime.year().month().day()))
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                
                Spacer().frame(height: 20)
                
                Text(journalEntry.entryTitle)
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer().frame(height: 20)
                
                Image(uiImage: journalEntry.photo ?? UIImage(systemName: "face.smiling")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Spacer().frame(height: 20)
                
                Image(uiImage: mapImage ?? UIImage(systemName: "map")!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 300, height: 300)
                
                Spacer().frame(height: 30)
            }
        }
        .navigationTitle("Entry Detail")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            getMapSnapshot()
        }
    }
    
    private func getMapSnapshot() {
        if let lat = journalEntry.latitude, let long = journalEntry.longitude {
            let options = MKMapSnapshotter.Options()
            options.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            options.size = CGSize(width: 300, height: 300)
            options.preferredConfiguration = MKStandardMapConfiguration()
            
            let snapShotter = MKMapSnapshotter(options: options)
            snapShotter.start { snapShot, error in
                if let snap = snapShot {
                    mapImage = snapShot?.image
                }else if let error = error {
                    print("error: \(error.localizedDescription)")
                }
                
            }
        }else {
            mapImage = UIImage(systemName: "map")
        }
    }
}
