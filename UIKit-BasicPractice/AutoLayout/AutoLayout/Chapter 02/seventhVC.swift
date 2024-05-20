//
//  seventhVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class seventhVC: UIViewController {
    let stepper = UIStepper()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "값: 0"
        
        stepper.minimumValue = 0
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.value = 0
        
        stepper.addAction(UIAction { [weak self] _ in
            self?.label.text = "값: \(self?.stepper.value ?? 0)"
        }, for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [label, stepper])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
