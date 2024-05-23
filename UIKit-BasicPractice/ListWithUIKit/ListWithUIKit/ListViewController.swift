//
//  ListViewController.swift
//  ListWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

struct Animal {
    let name: String
}

struct AnimalCategory {
    let category: String
    let animals: [Animal]
}

class ListViewController: UIViewController {
    let categories = [
        AnimalCategory(category: "파충류", animals: [Animal(name: "크레스티드 게코 도마뱀"), Animal(name: "레오파드 게코 도마뱀"), Animal(name: "토게이 게코 도마뱀")]),
        AnimalCategory(category: "포유류", animals: [Animal(name: "강아지"), Animal(name: "고양이"), Animal(name: "원숭이")]),
    ]
    
    let items = ["고양이", "강아지", "조류", "파충류", "어류"]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
        ])
    }


}

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories[section].animals.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section].category
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") ?? UITableViewCell(style: .default, reuseIdentifier: "cell")
        var config = cell.defaultContentConfiguration()
        config.text = categories[indexPath.section].animals[indexPath.row].name
        cell.contentConfiguration = config
        return cell
    }
    
