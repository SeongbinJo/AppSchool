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
    
    let slider = UISlider()
    let sliderLabel = UILabel()
    
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
        
        sliderLabel.text = "값: 0"
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 0.5
        
        slider.addAction(UIAction { [weak self] _ in
            self?.sliderLabel.text = "값: \(String(format: "%.1f", self?.slider.value ?? 0))"
        }, for: .valueChanged)
        
        let stackView2 = UIStackView(arrangedSubviews: [sliderLabel, slider])
        stackView2.axis = .vertical
        stackView2.spacing = 10
        stackView2.alignment = .center
        
        view.addSubview(stackView2)
        
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
}
