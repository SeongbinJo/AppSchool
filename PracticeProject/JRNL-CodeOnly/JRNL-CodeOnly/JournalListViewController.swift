//
//  ViewController.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit

class JournalListViewController: UIViewController {
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // tableView 오토레이아웃
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false // 컨스트레인트 수동으로 작성한다고 알려줌
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        navigationItem.title = "Journal"
        
        // 네비게이션 아이템 이용한 뷰 이동
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addJournal)) // #selector에 들어가는 함수는 objc
        navigationItem.rightBarButtonItems = [addButton]
    }
    
    @objc private func addJournal() {
        // 이동할 뷰를 선언하고 네비게이션 컨트롤러에 등록
        let addJournalViewController = AddJournalViewController()
        let navigationController  = UINavigationController(rootViewController: addJournalViewController)
        
        // 네비게이션 하는 뷰 띄우기
        present(navigationController, animated: true)
    }
    
}

