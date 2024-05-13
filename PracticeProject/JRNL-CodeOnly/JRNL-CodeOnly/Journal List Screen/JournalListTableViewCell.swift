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
        return dateLabel
    }()
    
    private lazy var titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        return titleLabel
    }()

    
    // Cell 생성자
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // 셀이 생성될 때마다 불림
        addSubview(thumbnailView)
        addSubview(dateLabel)
        addSubview(titleLabel)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
