//
//  PickerViewController.swift
//  PickerWithUIKit
//
//  Created by 조성빈 on 5/21/24.
//

import UIKit

class PickerViewController: UIViewController {
    private lazy var pickerView: UIPickerView = {
        let pickerView = UIPickerView()
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        return pickerView
    }()
    
    let options = ["Option 1", "Option 2", "Option 3", "Option 4", "Option 5"]
    let options2 = ["옵션 1", "옵션 2", "옵션 3", "옵션 4", "옵션 5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            pickerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
    
}

extension PickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return options.count
        case 1:
            return options2.count
        default:
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return options[row]
        case 1:
            return options2[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("selected row: \(row), component: \(component), value: \(component == 0 ? options[row] : options2[row])")
    }
    
}
