//
//  ThirdVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class ThirdVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.backgroundColor = .lightGray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is a"
        view.addSubview(label)
        
        // 최소 및 최대 너비 제약 조건 설정
        let maxWidth: CGFloat = 200
        let maxHeight: CGFloat = 200
        
        // 제약 조건 설정
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(lessThanOrEqualTo: view.trailingAnchor, constant: -20),
            label.widthAnchor.constraint(lessThanOrEqualToConstant: maxWidth),
            label.heightAnchor.constraint(lessThanOrEqualToConstant: maxHeight),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        // 텍스트 길이를 동적으로 변경
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            label.text = "This is an even longer text that should definitely exceed the maximum width constraint of the label. The maximum width constraint should keep the label's width within the bounds we set.This is an even longer text that should definitely exceed the maximum width constraint of the label. The maximum width constraint should keep the label's width within the bounds we set."
        }
    }
}
