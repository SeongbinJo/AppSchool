//
//  FirstVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class FirstVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "Hello, Auto Layout"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = false
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = false
        
        // safeAreaLayoutGuide -> 상단바, 하단바에 겹치지 않는 가이드 제공
        label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = false
    }
}
