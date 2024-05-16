//
//  AddJournalViewController.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit
import CoreLocation

protocol AddJournalControllerDelegate: NSObject {
    func saveJournalEntry(_ journalEntry: JournalEntry)
}

class AddJournalViewController: UIViewController {
    weak var delegate: AddJournalControllerDelegate?
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    
    
    var saveButton: UIBarButtonItem?
    var cancelButton: UIBarButtonItem?
    
    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var ratingView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemCyan
        return stackView
    }()
    
    private lazy var getLocationSwitch = UISwitch()
    private lazy var getLocationSwitchLabel: UILabel = {
        let label = UILabel()
        label.text = "현위치 가져오기"
        return label
    }()
    
    private lazy var toggleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8

        stackView.addArrangedSubview(getLocationSwitch)
        stackView.addArrangedSubview(getLocationSwitchLabel)
        return stackView
    }()
    
    private lazy var  titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Journal Title"
        return textField
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Journal Body"
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        imageView.image = UIImage(systemName: "face.smiling")
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "New Entry"
        view.backgroundColor = .white
        
        titleTextField.delegate = self
        bodyTextView.delegate = self
        locationManager.delegate = self
        
        // 탭 제스처 정의
        let imageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(openImagePicker(_:)))
        // 추가
        imageView.addGestureRecognizer(imageViewTapGesture)
        
        // 위치 가져오는 스위치 액션
        getLocationSwitch.addTarget(self, action: #selector(getLocationSwitchValueChanged(_:)), for: .valueChanged)

        saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEntry))
        cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEntry))
        
        saveButton?.isEnabled = false
        
        navigationItem.leftBarButtonItems = [cancelButton!]
        navigationItem.rightBarButtonItems = [saveButton!]
        
        mainContainer.addArrangedSubview(ratingView)
        mainContainer.addArrangedSubview(toggleStackView)
        mainContainer.addArrangedSubview(titleTextField)
        mainContainer.addArrangedSubview(bodyTextView)
        mainContainer.addArrangedSubview(imageView)
        view.addSubview(mainContainer)
        
        let safeArea = view.safeAreaLayoutGuide
        
        
        let components = [mainContainer, ratingView, toggleStackView, titleTextField, bodyTextView, imageView]
        for component in components {
            component.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            ratingView.widthAnchor.constraint(equalToConstant: 252),
            ratingView.heightAnchor.constraint(equalToConstant: 44),
            
            titleTextField.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            titleTextField.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            
            bodyTextView.leadingAnchor.constraint(equalTo: mainContainer.leadingAnchor, constant: 8),
            bodyTextView.trailingAnchor.constraint(equalTo: mainContainer.trailingAnchor, constant: -8),
            bodyTextView.heightAnchor.constraint(equalToConstant: 128),
            
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
        ])
    }
    
    //MARK: - 함수
    private func updateSaveButtonState() {
        let textFieldText = titleTextField.text ?? ""
        let textViewText = bodyTextView.text ?? ""
        if getLocationSwitch.isOn {
            saveButton!.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty && currentLocation != nil
        }else {
            saveButton!.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty
        }
    }
    
    @objc func saveEntry() {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else {
            return
        }
        let journalEntry = JournalEntry(rating: 3, title: title, body: body, photo: imageView.image)!
        delegate?.saveJournalEntry(journalEntry)
        dismiss(animated: true)
    }
    
    @objc func cancelEntry() {
        dismiss(animated: true)
    }
    
    @objc private func openImagePicker(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true)
    }
    
    @objc private func getLocationSwitchValueChanged(_ sender: UISwitch) {
        if getLocationSwitch.isOn {
            getLocationSwitchLabel.text = "위치 가져오는 중.."
            locationManager.requestLocation()
        }else {
            currentLocation = nil
            getLocationSwitchLabel.text = "다시 가져오기"
        }
    }
}

extension AddJournalViewController: UITextViewDelegate, UITextFieldDelegate {
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
}


extension AddJournalViewController: UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        let smallerImage = selectedImage.preparingThumbnail(of: CGSize(width: 300, height: 300))
        imageView.image = smallerImage
        dismiss(animated: true)
    }
}

extension AddJournalViewController: UINavigationControllerDelegate {
    
}

extension AddJournalViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let myCurrentLocation = locations.first {
            currentLocation = myCurrentLocation
            getLocationSwitchLabel.text = "위치를 가져왔습니다."
            updateSaveButtonState()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print("Failed to find user's location : \(error.localizedDescription)")
    }
}
