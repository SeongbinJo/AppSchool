//
//  AddJournalEntryViewController.swift
//  JRNL
//
//  Created by 조성빈 on 5/10/24.
//

import UIKit

class AddJournalEntryViewController: UIViewController {
    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var bodyTextView: UITextView!
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var saveButton: UIBarButtonItem!
    
    var newJournalEntry: JournalEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        bodyTextView.delegate = self
        updateSaveButtonState()
    }
    
    
    
    //MARD: - Methods
    private func updateSaveButtonState() {
        let textFieldText = titleTextField.text ?? ""
        let textViewText = bodyTextView.text ?? ""
        saveButton.isEnabled = !textFieldText.isEmpty && !textViewText.isEmpty
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let title = titleTextField.text ?? ""
        let body = bodyTextView.text ?? ""
        let photo = photoImageView.image
        let rating = 3
        newJournalEntry = JournalEntry(rating: rating, title: title, body: body, photo: photo)
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