//
//  ColorPickerViewController.swift
//  PickerWithUIKit
//
//  Created by 조성빈 on 5/21/24.
//

import UIKit

class ColorPickerViewController: UIViewController {
    
    // iOS에 자원(메모리)가 부족하면 호출되는 함수
    override func didReceiveMemoryWarning() {
        
    }
    
    
    let button: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "Color Picker"
        config.cornerStyle = .capsule
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button.addAction(UIAction { [unowned self] _ in
            let colorPicker = UIColorPickerViewController()
            colorPicker.delegate = self
            colorPicker.supportsAlpha = false // 투명도
            colorPicker.selectedColor = view.backgroundColor ?? .white
            self.present(colorPicker, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}

extension ColorPickerViewController: UIColorPickerViewControllerDelegate {
    func colorPickerViewController(_ viewController: UIColorPickerViewController, didSelect color: UIColor, continuously: Bool) {
//        view.backgroundColor = color
        view.backgroundColor = viewController.selectedColor
    }
    
    func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
        dismiss(animated: true)
    }
}
