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

class CustomCell: UITableViewCell {
    let animalImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        animalImageView.contentMode = .scaleAspectFit
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(animalImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            animalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            animalImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 50),
            animalImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: animalImageView.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
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
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
//        var config = cell.defaultContentConfiguration()
//        config.text = animals[indexPath.row].name
//        config.image = animals[indexPath.row].image
//        cell.contentConfiguration = config
        cell.animalImageView.image = animals[indexPath.row].image
        cell.nameLabel.text = animals[indexPath.row].name
        
        return cell
    }
    
    
}
