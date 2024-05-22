//
//  RotationGestureViewController.swift
//  GestureWithUIKit
//
//  Created by 조성빈 on 5/22/24.
//

import UIKit

class RotationGestureViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.frame = CGRect(x: view.bounds.midX-100, y: view.bounds.midY-100, width: 200, height: 200)
        imageView.isUserInteractionEnabled = true
        
        let gesture = UIRotationGestureRecognizer(target: self, action: #selector(handleGesture))
        imageView.addGestureRecognizer(gesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(imageView)
    }

    @objc func handleGesture(_ sender: UIRotationGestureRecognizer) {
        if let view = sender.view {
            view.transform = view.transform.rotated(by: sender.rotation)
            sender.rotation = 0
        }
    }
}
