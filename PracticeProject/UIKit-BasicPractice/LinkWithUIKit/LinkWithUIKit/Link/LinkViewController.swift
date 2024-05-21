//
//  LinkViewController.swift
//  LinkWithUIKit
//
//  Created by 조성빈 on 5/21/24.
//

import UIKit
import WebKit
import SafariServices

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
    
    private lazy var webViewButton: UIButton = {
        let button = UIButton(type: .system)
        var config = UIButton.Configuration.filled()
        config.title = "naver"
        button.configuration = config
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        // 앱 내에서 웹뷰 띄우기
        button.addAction(UIAction { [weak self] _ in
            if let url = URL(string: "https://www.naver.com") {
                // 공간을 따로 할당해서 띄우기
                self?.openWebView(url: url)
                
                // 앱 내에서 웹뷰 꽉채워서 띄우기 -> Safari 만 가능
                //                let safariViewController = SFSafariViewController(url: url)
                //                safariViewController.modalPresentationStyle = .formSheet // 띄우는 방식 지정
                //                self?.present(safariViewController, animated: true)
            }
        }, for: .touchUpInside)
        return button
    }()
    
    private lazy var closeWebViewButton: UIButton = {
        let button = UIButton(type: .close)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addAction(UIAction { [weak self] _ in
            self?.webView.isHidden = true
        }, for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(linkButton)
        view.addSubview(webView)
        view.addSubview(webViewButton)
        webView.addSubview(closeWebViewButton)
        
        NSLayoutConstraint.activate([
            linkButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            linkButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            webViewButton.topAnchor.constraint(equalTo: linkButton.topAnchor),
            webViewButton.leadingAnchor.constraint(equalTo: linkButton.trailingAnchor, constant: 20),
            
            closeWebViewButton.topAnchor.constraint(equalTo: webViewButton.topAnchor),
            closeWebViewButton.leadingAnchor.constraint(equalTo: webViewButton.trailingAnchor, constant: 20),
            
            webView.topAnchor.constraint(equalTo: linkButton.bottomAnchor, constant: 20),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    func openWebView(url: URL) {
        let request = URLRequest(url: url)
        webView.load(request)
        webView.isHidden = false
    }
    
}
