//
//  JournalDetailTableViewController.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var stackView: UIStackView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemCyan
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 252),
            stackView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
}

class JournalDetailTableViewController: UITableViewController {
    let journalEntry: JournalEntry
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "Date"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bodyTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.backgroundColor = .systemBackground
        textView.textColor = .label
        textView.font = UIFont.systemFont(ofSize: 14)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var mapView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "map")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(journalEntry: JournalEntry) {
        self.journalEntry = journalEntry
        super.init(nibName: nil, bundle:nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")
        navigationItem.title = "Detail"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(dateLabel)
            dateLabel.text = journalEntry.dateString

            let marginGuide = cell.contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                dateLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                dateLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(titleLabel)
            titleLabel.text = journalEntry.title
            let marginGuide = cell.contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                titleLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(bodyTextView)
            bodyTextView.text = journalEntry.body
            let marginGuide = cell.contentView.layoutMarginsGuide
            NSLayoutConstraint.activate([
                bodyTextView.topAnchor.constraint(equalTo: marginGuide.topAnchor),
                bodyTextView.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor),
                bodyTextView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor),
                bodyTextView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
            ])
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(imageView)
            if let photoData = journalEntry.photoData {
                imageView.image = UIImage(data: photoData)
            }
            NSLayoutConstraint.activate([
                imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                imageView.widthAnchor.constraint(equalToConstant: 300),
                imageView.heightAnchor.constraint(equalToConstant: 300)
            ])
            return cell
        case 5:
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.contentView.addSubview(mapView)
            NSLayoutConstraint.activate([
                mapView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
                mapView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
                mapView.widthAnchor.constraint(equalToConstant: 300),
                mapView.heightAnchor.constraint(equalToConstant: 300)
            ])
            return cell
        default:
            return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 1: return 60
        case 3: return 150
        case 4: return 316
        case 5: return 316
        default: return 44.5
        }
    }

}
