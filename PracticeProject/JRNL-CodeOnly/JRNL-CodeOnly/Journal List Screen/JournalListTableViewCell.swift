//
//  JournalListTableViewCell.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit

class JournalListTableViewCell: UITableViewCell {
    
    private lazy var thumbnailView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "face.smiling")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.text = "Date"
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return dateLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Title"
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return titleLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(thumbnailView)
        addSubview(dateLabel)
        addSubview(titleLabel)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = self.safeAreaLayoutGuide
        let marginGuide = self.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            thumbnailView.widthAnchor.constraint(equalToConstant: 90),
            
            dateLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -8),

            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -8)
            
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configureCell
    func configureCell(journalEntry: JournalEntry) {
        thumbnailView.image = journalEntry.photo
        dateLabel.text  = journalEntry.date.formatted(.dateTime.year().month().day())
        titleLabel.text = journalEntry.entryTitle
    }
}
