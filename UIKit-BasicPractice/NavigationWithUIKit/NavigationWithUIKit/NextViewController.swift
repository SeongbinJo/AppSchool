//
//  NextViewController.swift
//  NavigationWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

protocol NextViewControllerDelegate {
    func save(animal: Animal)
}

class NextViewController: UIViewController {
    var animal: Animal?
    
    var delegate: NextViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        self.navigationItem.title = "다음 화면 제목"
        
        let label = UILabel()
        label.text = animal?.name ?? "-"
        if let animal = self.animal, let delegate = self.delegate {
            delegate.save(animal: Animal(name: "피자사줘"))
            self.navigationController?.popViewController(animated: true)
        }
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }

}
