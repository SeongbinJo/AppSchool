//
//  ViewController.swift
//  NotificationWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

class ViewController: UIViewController {
    let textField = UITextField()

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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapHandler))
        view.addGestureRecognizer(tapGesture)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // 슈퍼 뷰 클릭시 키보드 내려감
    @objc func tapHandler(_ sender: UIView) {
        textField.resignFirstResponder()
    }

    @objc func keyboardWillShow(_ notification: NSNotification) {
        print("Keyboard is up")
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        print("Keyboard is down")
    }
}

