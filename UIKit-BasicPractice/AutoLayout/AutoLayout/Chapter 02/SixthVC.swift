//
//  SixthVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class SixthVC: UIViewController {
    
    let toggleSwitch = UISwitch()
    let label = UILabel()
    
    let toggleSwitch2 = UISwitch()
    let label2 = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()

        label.text = "Switch is OFF"
        label.textAlignment = .center
        
        // addTarget 모디파이어 사용한 예제
        toggleSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [label, toggleSwitch])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        
        
        
        label2.text = "Switch2 is OFF"
        label2.textAlignment = .center
        
        
        // addAction을 사용한 예제 (iOS 14+)
        toggleSwitch2.addAction(
            UIAction { [weak self] _ in // [weak self] -> 이스케이핑 클로저는 클로저 스코프 밖에서 도는 클로저이므로 메모리 해제가 안될 수 있어서 메모리 누수가 일어날 수 있기 때문에 사용한다.
                if let isOn = self?.toggleSwitch2.isOn, isOn {
                    self?.label2.text = "Switch2 is ON"
                }else {
                    self?.label2.text = "Switch2 is OFF"
                }
            }, for: .valueChanged
        )
        
        let stackView2 = UIStackView(arrangedSubviews: [label2, toggleSwitch2])
        stackView2.axis = .vertical
        stackView2.spacing = 10
        stackView2.alignment = .center
        stackView2.distribution = .fillEqually
        
        view.addSubview(stackView2)
        
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView2.topAnchor.constraint(equalTo: stackView.bottomAnchor),
            stackView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        if sender.isOn {
            label.text = "Switch is ON"
        }else {
            label.text = "Switch is OFF"
        }
    }
}
