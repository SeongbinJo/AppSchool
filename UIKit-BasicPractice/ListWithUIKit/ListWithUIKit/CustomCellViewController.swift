//
//  CustomCellViewController.swift
//  ListWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

struct AnimalStruct {
    let name: String
    let image: UIImage
}

class CustomCellViewController: UIViewController {
    let animals = [
        AnimalStruct(name: "강아지", image: UIImage(systemName: "dog")!),
        AnimalStruct(name: "고양이", image: UIImage(systemName: "cat")!),
        AnimalStruct(name: "토끼", image: UIImage(systemName: "hare")!),
    ]
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(tableView)
    }

}

extension CustomCellViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.text = animals[indexPath.row].name
        config.image = animals[indexPath.row].image
        cell.contentConfiguration = config
        return cell
    }
    
    
}
