//
//  LinkViewController.swift
//  LinkWithUIKit
//
//  Created by 조성빈 on 5/21/24.
//

import UIKit

class LinkViewController: UIViewController {
    let linkButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Apple"
        button.configuration = config
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        linkButton.addAction(UIAction { _ in
            if let url = URL(string: "https://www.apple.com") {
                UIApplication.shared.open(url)
            }
        }, for: .touchUpInside)
        
        view.addSubview(linkButton)
        
        NSLayoutConstraint.activate([
            linkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linkButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
