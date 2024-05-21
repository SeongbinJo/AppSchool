//
//  DatePickerViewController.swift
//  PickerWithUIKit
//
//  Created by 조성빈 on 5/21/24.
//

import UIKit

class DatePickerViewController: UIViewController {
    let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let today = Date()
        var dateComponents = DateComponents()
        dateComponents.year = 1 // 음수로 값을 주면 이전 범위도 가능
        let oneYearFromNow = Calendar.current.date(byAdding: dateComponents, to: today) // today로부터 dateComponents 만큼 더함
        
        datePicker.minimumDate = today
        datePicker.maximumDate = oneYearFromNow
        
        datePicker.addAction(UIAction { [weak self] _ in
            print("sender: \(self?.datePicker.date.formatted(.dateTime.year().month().day()) ?? "N/A")")
        }, for: .valueChanged)
        
        view.addSubview(datePicker)
        
        NSLayoutConstraint.activate([
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            datePicker.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
