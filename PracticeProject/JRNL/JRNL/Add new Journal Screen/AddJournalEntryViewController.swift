//
//  AddJournalEntryViewController.swift
//  JRNL
//
//  Created by 조성빈 on 5/10/24.
//

import UIKit
import CoreLocation

class AddJournalEntryViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    @IBOutlet var getLocationSwitch: UISwitch!
    @IBOutlet var getLocationSwitchLabel: UILabel!
    
    @IBOutlet var ratingView: RatingView!
    
    
    var newJournalEntry: JournalEntry?
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        bodyTextView.delegate = self
        updateSaveButtonState()
        
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
    }
    
    @IBAction func getLocationSwitchValueChanged(_ sender: UISwitch) {
        if getLocationSwitch.isOn {
            getLocationSwitchLabel.text = "Getting location..."
            locationManager.requestLocation() // 위치 요청
        }else {
            currentLocation = nil
            getLocationSwitchLabel.text = "Get location"
        }
    }
    
    @IBAction func getPhotof(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    
    //MARK: - Methods
    private func updateSaveButtonState() {
        let textFieldText = titleTextField.text ?? ""
        let textViewText = bodyTextView.text ?? ""
        if getLocationSwitch.isOn {
            saveButton.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty && currentLocation != nil
        }else {
            saveButton.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let title = titleTextField.text ?? ""
        let body = bodyTextView.text ?? ""
        let photo = photoImageView.image
        let rating = ratingView.rating
        let lat = currentLocation?.coordinate.latitude
        let long = currentLocation?.coordinate.longitude
        newJournalEntry = JournalEntry(rating: rating, title: title, body: body, photo: photo, latitude: lat, longitude: long)
    }

}


extension AddJournalEntryViewController: UITextViewDelegate, UITextFieldDelegate {
    //MARK: - UITextFieldDelegate
    // shouldReturn -> 키보드의 리턴 키를 탭할때 불림
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // 키보드를 내려줌
        return true
    }
    
    // 텍스트 입력 종료시 확인 한 번 하는 것
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        updateSaveButtonState()
    }
    
    // 텍스트 입력할때마다 불림
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        
//    }
    
    //MARK: - UITextViewDelegate
    // shouldChangeTextIn -> 텍스트가 입력될때 불림
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") { // Enter를 눌렀을때
            textView.resignFirstResponder() // 키보드를 내려줌
        }
        return true
    }
    
    // 텍스트 입력 종료시 확인 한 번 하는 것
    func textViewDidEndEditing(_ textView: UITextView) {
        updateSaveButtonState()
    }
}


extension AddJournalEntryViewController: CLLocationManagerDelegate {
    //MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCurrentLocation = locations.first {
            currentLocation = myCurrentLocation
            getLocationSwitchLabel.text = "Done"
            updateSaveButtonState()
        }
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location : \(error.localizedDescription)")
    }
}


extension AddJournalEntryViewController: UIImagePickerControllerDelegate {
    
}


extension AddJournalEntryViewController: UINavigationControllerDelegate {
    
}
