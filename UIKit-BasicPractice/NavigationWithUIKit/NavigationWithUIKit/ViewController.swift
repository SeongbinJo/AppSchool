//
//  ViewController.swift
//  NavigationWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "네비게이션 타이틀"
        
        self.navigationController?.navigationBar.barStyle = .default
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.barTintColor = .systemCyan
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.red]
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(leftButtonTapped))
        let rightButton = UIBarButtonItem(title: "완료(오른쪽)", style: .done, target: self, action: #selector(rightButtonTapped))
        let extraButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(extraButtonTapped))
        self.navigationItem.leftBarButtonItems = [leftButton]
        self.navigationItem.rightBarButtonItems = [rightButton, extraButton]
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

