//
//  JournalEntryDetailTableViewController.swift
//  JRNL
//
//  Created by 조성빈 on 5/10/24.
//

import UIKit
import MapKit

class JournalEntryDetailTableViewController: UITableViewController {
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var mapImageView: UIImageView!
    
    var selectedJournalEntry: JournalEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateLabel.text = selectedJournalEntry?.dateString
        titleLabel.text = selectedJournalEntry?.title
        bodyTextView.text = selectedJournalEntry?.body
        if let photoData = selectedJournalEntry?.photoData {
            photoImageView.image = UIImage(data: photoData)
        }
        getMapSnapshot()
    }
    
    //MARK: - Private Methods
    // 맵의 스크린샷을 찍어 옴
    private func getMapSnapshot() {
        if let lat = selectedJournalEntry?.latitude, let long = selectedJournalEntry?.longitude {
            let options = MKMapSnapshotter.Options()
            options.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: long), span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            options.size = CGSize(width: 300, height: 300)
            options.preferredConfiguration = MKStandardMapConfiguration()
            let snapShotter = MKMapSnapshotter(options: options)
            snapShotter.start { snapShot, error in
                if let snapshot = snapShot {
                    self.mapImageView.image = snapshot.image
                }else if let error = error {
                    print("Map snapShot error : \(error.localizedDescription)")
                }
            }
        } else {
            self.mapImageView.image = UIImage(systemName: "map")
        }
    }

}
