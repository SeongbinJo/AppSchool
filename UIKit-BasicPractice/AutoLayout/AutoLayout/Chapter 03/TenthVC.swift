//
//  TenthVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit
import WebKit

class TenthVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false

        let htmlString = """
        <html>
        <head>
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <style>
                body {
                    font-family: -apple-system, Helvetica, Arial, sans-serif;
                    font-size: 2rem;
                    display: flex;
                    align-items: center;
                    justify-content: center;
                }
                .italic {
                    font-style: italic;
                }
                .blue {
                    color: blue;
                }
                .underline {
                    text-decoration: underline;
                }
                
            </style>
        </head>
        <body>
            <span class="italic underline">Hello,&nbsp;</span><span class="blue underline">World</span>
        </body>
        </html>
        """

        webView.loadHTMLString(htmlString, baseURL: nil)

        view.addSubview(webView)

        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }


}
