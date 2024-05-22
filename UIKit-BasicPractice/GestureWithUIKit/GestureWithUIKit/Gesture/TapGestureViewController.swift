//
//  TapGestureViewController.swift
//  GestureWithUIKit
//
//  Created by 조성빈 on 5/22/24.
//

import UIKit

class TapGestureViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let rectangle = UIView()
        rectangle.backgroundColor = .yellow
        rectangle.frame = CGRect(x: 100, y: 100, width: 175, height: 125)
        rectangle.isUserInteractionEnabled = true // 클릭 허용 여부
        
        view.addSubview(rectangle)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        tapGesture.numberOfTapsRequired = 2
        rectangle.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if let view = sender.view {
            view.backgroundColor = (view.backgroundColor == .yellow) ? .red : .yellow
        }
    }
    
}
