//
//  ViewController.swift
//  CustomDatePicker
//
//  Created by 조성빈 on 5/22/24.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private lazy var datePicker: UIPickerView = {
        let picker = UIPickerView()
        picker.delegate = self
        picker.dataSource = self
        return picker
    }()
    
    let years = [Int](2000...2050)
    let months = [Int](1...12)
    let days = [Int](1...31)
    
    var selectedYear = 0
    var selectedMonth = 0
    var selectedDay = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            if selectedMonth == 2 {
                return (((selectedYear % 4) == 0) &&
                        ((selectedYear % 100) != 0) || selectedYear % 400 == 0) ? 29 : 28
            } else if [4,6,9,11].contains(selectedMonth) {
                return 30
            } else {
                return days.count
            }
        default:
            return 0
        }
    }
    
    // MARK: - UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return String(describing:years[row])
        case 1:
            return String(describing:months[row])
        case 2:
            return String(describing:days[row])
        default:
            return nil
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedYear = years[row]
            pickerView.reloadComponent(2)
        case 1:
            selectedMonth = months[row]
            pickerView.reloadComponent(2)
        case 2:
            selectedDay = days[row]
        default:
            return
        }
    }
}
