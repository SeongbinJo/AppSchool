//
//  eighthVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class eighthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let leftLabel = UILabel()
        leftLabel.text = "왼쪽"
        leftLabel.backgroundColor = .lightGray
        
        let rightLabel = UILabel()
        rightLabel.text = "오른쪽"
        rightLabel.backgroundColor = .systemCyan
        
        let spacer = UIView()
        spacer.backgroundColor = .systemGreen
        spacer.setContentHuggingPriority(.defaultLow, for: .horizontal)
        spacer.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        stackView.addArrangedSubview(leftLabel)
        stackView.addArrangedSubview(spacer)
        stackView.addArrangedSubview(rightLabel)
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}
