//
//  FourthVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class FourthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let containerView = UIView()
        containerView.backgroundColor = .lightGray
        containerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 200),
            containerView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        let subView1 = UIView()
        subView1.backgroundColor = .red
        subView1.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subView1)
        
        let subView2 = UIView()
        subView2.backgroundColor = .blue
        subView2.translatesAutoresizingMaskIntoConstraints = false
        containerView.addSubview(subView2)
        
        NSLayoutConstraint.activate([
            subView1.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            subView1.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            subView1.widthAnchor.constraint(equalToConstant: 50),
            subView1.heightAnchor.constraint(equalToConstant: 50),
            
            subView2.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            subView2.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            subView2.widthAnchor.constraint(equalTo: subView1.widthAnchor, multiplier: 2.0),
            subView2.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
    

}
