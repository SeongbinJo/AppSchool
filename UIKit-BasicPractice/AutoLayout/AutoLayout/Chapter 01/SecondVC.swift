//
//  SecondVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class SecondVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let box = UIView()
        box.backgroundColor = .red
        box.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(box)
        
        NSLayoutConstraint.activate([
            box.widthAnchor.constraint(equalToConstant: 100),
            box.heightAnchor.constraint(equalToConstant: 100),
            
            box.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            box.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            box.widthAnchor.constraint(lessThanOrEqualToConstant: 200),
            box.heightAnchor.constraint(greaterThanOrEqualToConstant: 50)
        ])
    }
    


}
