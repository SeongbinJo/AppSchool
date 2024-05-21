//
//  LinkViewController.swift
//  LinkWithUIKit
//
//  Created by 조성빈 on 5/21/24.
//

import UIKit
import WebKit

class LinkViewController: UIViewController {
    let linkButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "Apple"
        button.configuration = config
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        button.addAction(UIAction { _ in
            if let url = URL(string: "https://www.apple.com") {
                UIApplication.shared.open(url)
            }
        }, for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var webView: WKWebView = {
        let webView = WKWebView(frame: .zero)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.isHidden = true
        return webView
    }()
    
    let webViewButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "naver"
        button.configuration = config
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(linkButton)
        view.addSubview(webView)
        view.addSubview(webViewButton)
        
        NSLayoutConstraint.activate([
            linkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            webViewButton.topAnchor.constraint(equalTo: linkButton.topAnchor),
            webViewButton.leadingAnchor.constraint(equalTo: linkButton.trailingAnchor, constant: 20),
            
            webView.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
        
        webViewButton.addAction(UIAction { [weak self] _ in
            if let url = URL(string: "https://www.naver.com") {
                self?.openWebView(url: url)
            }
        }, for: .touchUpInside)
    }
    
    func openWebView(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
        webView.isHidden = false
    }

}
