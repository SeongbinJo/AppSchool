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
        dateLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        dateLabel.text = "TEST"
        return dateLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        titleLabel.text = "test"
        return titleLabel
    }()

    
    // Cell 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 셀이 생성될 때마다 불림
        addSubview(thumbnailView)
        addSubview(dateLabel)
        addSubview(titleLabel)
        
        thumbnailView.translatesAutoresizingMaskIntoConstraints = false
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let safeArea = safeAreaLayoutGuide // 전체화면에 대한 가이드
        let marginGuide = layoutMarginsGuide // 기본여백 설정 가이드
        
        NSLayoutConstraint.activate([
            thumbnailView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            thumbnailView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            thumbnailView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            thumbnailView.widthAnchor.constraint(equalToConstant: 90),
            
            dateLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: thumbnailView.trailingAnchor, constant: 8),
            dateLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
