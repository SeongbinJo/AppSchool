//
//  ViewController.swift
//  NavigationWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

class ViewController: UIViewController, NextViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "네비게이션 타이틀"
        
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        appearance.backgroundColor = .systemCyan
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(leftButtonTapped))
        let rightButton = UIBarButtonItem(title: "완료(오른쪽)", style: .done, target: self, action: #selector(rightButtonTapped))
        let extraButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(extraButtonTapped))
        self.navigationItem.leftBarButtonItems = [leftButton]
        self.navigationItem.rightBarButtonItems = [rightButton, extraButton]
        
        let button = UIButton(type: .system)
        button.setTitle("다음 화면으로", for: .normal)
        button.addAction(UIAction { [weak self] _ in
            print("다음 화면으로 => 탭됨.")
            let nextViewController = NextViewController()
            nextViewController.animal = Animal(name: "배고파")
            nextViewController.delegate = self
            self?.show(nextViewController, sender: nil)
        }, for: .touchUpInside)
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 50)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(button)
        
        NSLayoutConstraint.activate([
            
        ])
    }
    
    func save(animal: Animal) {
        print("\(animal) 출력")
    }

    @objc func leftButtonTapped() {
        print("왼쪽 버튼 탭됨.")
    }

    @objc func rightButtonTapped() {
        print("오른쪽 버튼 탭됨.")
    }
    
    @objc func extraButtonTapped() {
        print("추가 버튼 탭됨.")
    }
}

