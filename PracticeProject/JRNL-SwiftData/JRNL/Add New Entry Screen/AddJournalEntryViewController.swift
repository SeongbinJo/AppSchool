//
//  AddJournalEntryViewController.swift
//  JRNL
//
//  Created by Jungman Bae on 5/10/24.
//

import UIKit
import CoreLocation

class AddJournalEntryViewController: UIViewController, UITextFieldDelegate,
                                     UITextViewDelegate, CLLocationManagerDelegate,
                                     UIImagePickerControllerDelegate, UINavigationControllerDelegate
{

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
    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        let title = titleTextField.text ?? ""
        let body = bodyTextView.text ?? ""
        let photo = photoImageView.image
        let rating = ratingView.rating
        let lat = currentLocation?.coordinate.latitude
        let long = currentLocation?.coordinate.longitude
        newJournalEntry = JournalEntry(rating: rating, title: title,
                                       body: body, photo: photo,
                                       latitude: lat, longitude: long)
    }

    // MARK: - UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateSaveButtonState()
        return true
    }
        
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateSaveButtonState()
    }
    
    // MARK: - UITextViewDelegate
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        print("text: \(range.description) \(text)")
        if(text == "\n") {
            textView.resignFirstResponder()
        }
        updateSaveButtonState()
        return true
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updateSaveButtonState()
    }
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCurrentLocation = locations.first {
            currentLocation = myCurrentLocation
            getLocationSwitchLabel.text = "Done"
            updateSaveButtonState()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    // MARK: - UIImagePickerControllerDelegate
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let smallerImage = selectedImage.preparingThumbnail(of: CGSize(width: 300, height: 300))
        photoImageView.image = smallerImage
        dismiss(animated: true)
    }
    
    // MARK: - Methods
    private func updateSaveButtonState() {
        let textFieldText = titleTextField.text ?? ""
        let textViewText = bodyTextView.text ?? ""
        if getLocationSwitch.isOn {
            saveButton.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty && currentLocation != nil
        } else {
            saveButton.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty
        }
    }
    
    @IBAction func getLocationSwitchValueChanged(_ sender: UISwitch) {
        if getLocationSwitch.isOn {
            getLocationSwitchLabel.text = "Getting location..."
            locationManager.requestLocation()
        } else {
            currentLocation = nil
            getLocationSwitchLabel.text = "Get location"
        }
    }
    
    
    @IBAction func getPhoto(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
}
