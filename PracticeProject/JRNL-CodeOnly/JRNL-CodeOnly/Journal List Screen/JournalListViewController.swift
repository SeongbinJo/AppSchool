//
//  ViewController.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit

class JournalListViewController: UIViewController, AddJournalControllerDelegate {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(JournalListTableViewCell.self, forCellReuseIdentifier: "journalCell") // Cell 등록

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
            
            addJournalViewController.delegate = self
            
            // 네비게이션 하는 뷰 띄우기(모달 형식)
            present(navController, animated: true)
        }
    
    // AddJournalControllerDelegate 프로토콜을 사용하면 따라와야하는 함수.
    public func saveJournalEntry(_ journalEntry: JournalEntry) {
        SharedData.shared.addJournalEntry(newJournalEntry: journalEntry)
        tableView.reloadData()
    }
    
}

extension JournalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SharedData.shared.numberOfJournalEntries()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell
        let journalEntry = SharedData.shared.getJournalEntry(index: indexPath.row)
        cell.configureCell(journalEntry: journalEntry)
        return cell
    }
    
    //MARK: - UITableViewDelegate 기능 함수
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let journalEntry = SharedData.shared.getJournalEntry(index: indexPath.row)
        let journalDetailViewController = JournalDetailTableViewController(journalEntry: journalEntry)
        
        // 네비게이션 뷰 띄우기(네비게이션 형식)
        show(journalDetailViewController, sender: self)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SharedData.shared.removeJournalEntry(index: indexPath.row)
            tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
}
