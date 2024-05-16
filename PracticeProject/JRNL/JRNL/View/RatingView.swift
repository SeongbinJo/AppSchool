//
//  RatingView.swift
//  JRNL
//
//  Created by 조성빈 on 5/16/24.
//

import UIKit

class RatingView: UIStackView {
    private var ratingButtons = [UIButton()]
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    private let buttonSize = CGSize(width: 44.0, height: 44.0)
    private let buttonCount = 5
    
    //MARK: - Initialization
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    //MARK: - Private Methods
    private func setupButtons() {
        // 별 버튼을 모두 제거하여 흰 도화지로 만듦.
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        // 상황별 별의 이미지를 정의
        let filledStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")
        let highlightedStar = UIImage(systemName: "star.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal)
        
        // 흰 도화지에 새로운 별 그리기
        for _ in 0..<buttonCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            
            // 레이아웃
            button.translatesAutoresizingMaskIntoConstraints = false
//            NSLayoutConstraint.activate([
//                button.widthAnchor.constraint(equalToConstant: buttonSize.width),
//                button.heightAnchor.constraint(equalToConstant: buttonSize.height)
//            ])
            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside) // self로 이미 되어있기 때문에 button: 에 button을 넣지 않아도 됨.
            addArrangedSubview(button)
            
            // 버튼 추가
            ratingButtons.append(button)
        }
    }
    
    private func updateButtonSelectionState() {
        for (index, button) in ratingButtons.enumerated() {
            button.isSelected = index < rating
        }
    }
    
    @objc func ratingButtonTapped(button: UIButton) {
        guard let index = ratingButtons.firstIndex(of: button) else {
            fatalError("The button, \(button), is not in the ratingbuttons array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        }else {
            rating = selectedRating
        }
    }
}
