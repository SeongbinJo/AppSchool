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
    
    var newJournalEntry: JournalEntry?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.delegate = self
        bodyTextView.delegate = self
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
    
    //MARK: - UITextViewDelegate
    // shouldChangeTextIn -> 텍스트가 입력될때 불림
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if (text == "\n") { // Enter를 눌렀을때
            textView.resignFirstResponder() // 키보드를 내려줌
        }
        return true
    }
}
