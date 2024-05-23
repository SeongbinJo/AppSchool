//
//  ViewController.swift
//  NotificationWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

class ViewController: UIViewController {
    let textField = UITextField()
    
    lazy var tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField.borderStyle = .roundedRect
        textField.placeholder = "여기에 입력하세요."
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 100),
        ])
        
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.removeGestureRecognizer(tapGesture)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 슈퍼 뷰 클릭시 키보드 내려감
    @objc func tapHandler(_ sender: UIView) {
        textField.resignFirstResponder()
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        print("Keyboard is up")
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardSize.height
            if view.frame.origin.y == 0 {
                view.frame.origin.y -= (keyboardHeight - textField.frame.height)
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        print("Keyboard is down")
        if view.frame.origin.y != 0 {
            view.frame.origin.y = 0
        }
    }
}

