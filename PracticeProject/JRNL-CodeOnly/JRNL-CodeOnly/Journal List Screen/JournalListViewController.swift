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
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell") // Cell 등록
        
        
//        let safeArea = safeAreaLayoutGuide // 전체화면에 대한 가이드
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
    
    //MARK: - AddJournalVC로 이동하는 함수
    @objc private func addJournal() {
        // 이동할 뷰를 선언하고 네비게이션 컨트롤러에 등록
        let addJournalViewController = AddJournalViewController()
        let navController  = UINavigationController(rootViewController: addJournalViewController)
        
        // 네비게이션 하는 뷰 띄우기(모달 형식)
        present(navController, animated: true)
    }
    
    @objc private func detailJournal() {
        let journalDetailViewController = JournalDetailTableViewController()
        
        // 네비게이션 뷰 띄우기(네비게이션 형식)
        show(journalDetailViewController, sender: self)
    }
    
}

extension JournalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        return cell
    }
    
    //MARK: - UITableViewDelegate 기능 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        detailJournal()
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
}
