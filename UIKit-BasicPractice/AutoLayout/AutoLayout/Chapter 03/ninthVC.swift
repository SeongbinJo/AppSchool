//
//  ninthVC.swift
//  AutoLayout
//
//  Created by 조성빈 on 5/20/24.
//

import UIKit

class ninthVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel()
        label.text = "미;ㅈ다ㅓ라ㅣ;ㅊㅁㅈ츷디;ㅏ믖디;가ㅢ; 바ㄷjm;dlkmㅣ;ㅏㄴ의;파믄이ㅏ츠미;느이;르lmas;dlmcv;lszmdfv;lkamwl;ekmc;lkmw;lkmas;lk"
        label.textColor = .yellow
        label.backgroundColor = .red
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
        ])
    }
}
