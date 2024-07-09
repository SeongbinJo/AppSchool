//
//  ViewController.swift
//  CodeonlyUIKitWithSwiftUI
//
//  Created by 조성빈 on 7/8/24.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.plain()
        config.title = "버턴!"
        button.configuration = config
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        title = "콜드재현"
        
        button.addAction(UIAction { [weak self] action in
            let hostingController = UIHostingController(rootView: SwiftUIView())
            self?.navigationController?.pushViewController(hostingController, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }


}

