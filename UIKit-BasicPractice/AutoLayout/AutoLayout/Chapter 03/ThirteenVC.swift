//
//  ThirteenVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class ThirteenVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageView = UIImageView(image: UIImage(systemName: "hare.fill"))
        imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 100)
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.clipsToBounds = true
        
        imageView.layer.shadowColor = UIColor.red.cgColor
        imageView.layer.shadowOpacity = 0.8
        imageView.layer.shadowOffset = CGSize(width: 10, height: 10)
        imageView.layer.shadowRadius = 6
        
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.layer.borderWidth = 10
        
        imageView.alpha = 0.75
        
        self.view.addSubview(imageView)
        
        let flagImageView = UIImageView(image: UIImage(systemName: "flag"))
        flagImageView.frame = CGRect(x: 50, y: 200, width: 100, height: 50)
        flagImageView.clipsToBounds = true
        flagImageView.contentMode = .scaleAspectFill
        self.view.addSubview(flagImageView)
        
    }

}
