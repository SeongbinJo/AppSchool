//
//  PanGestureViewController.swift
//  GestureWithUIKit
//
//  Created by 조성빈 on 5/22/24.
//

import UIKit

class PanGestureViewController: UIViewController {
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "star.fill"))
        imageView.frame = CGRect(x: view.bounds.midX-100, y: view.bounds.midY-100, width: 200, height: 200)
        imageView.isUserInteractionEnabled = true
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        imageView.addGestureRecognizer(gesture)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(imageView)
    }
    
    @objc func handlePanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: view)
        if let view = sender.view {
            view.center = CGPoint(x: view.center.x + translation.x, y: view.center.y + translation.y)
            sender.setTranslation(.zero, in: view)
        }
    }
}

extension PanGestureViewController: UIGestureRecognizerDelegate {
    // 여러개의 제스쳐가 있을 경우 제어하기 위함
    // 단일 제스쳐 허용 여부
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer is UIPanGestureRecognizer {
            return false
        }else {
            return true
        }
    }
    
    // 여러개의 제스쳐를 동시 제어가 가능한지에 대한 여부 "ex) 회전하면서 줌"
    // 복합 제스처 허용 여부
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
