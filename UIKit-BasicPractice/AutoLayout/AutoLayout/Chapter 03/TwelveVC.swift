//
//  TwelveVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class TwelveVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(image: UIImage(systemName: "hare.fill"))
        imageView.frame = CGRect(x: 50, y: 50, width: 100, height: 50)
        imageView.tintColor = .purple
        imageView.contentMode = .scaleAspectFit
        self.view.addSubview(imageView)
        
        let flagImageView = UIImageView(image: UIImage(systemName: "flag"))
        flagImageView.frame = CGRect(x: 70, y: 200, width: 100, height: 50)
        flagImageView.clipsToBounds = true
        flagImageView.contentMode = .scaleAspectFill
        self.view.addSubview(flagImageView)
    }

}
