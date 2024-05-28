//
//  RatingView.swift
//  JRNL
//
//  Created by Jungman Bae on 5/16/24.
//

import UIKit

class RatingView: UIStackView {
    private var ratingButtons: [UIButton] = []
    var rating = 0 {
        didSet {
            updateButtonSelectionState()
        }
    }
    private let buttonSize = CGSize(width: 44.0, height: 44.0)
    private let buttonCount = 5
    
    // MARK: - Initialization
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    
    // MARK: - Private Methods
    private func setupButtons() {
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        let filledStar = UIImage(systemName: "star.fill")
        let emptyStar = UIImage(systemName: "star")
        let highlightedStar = UIImage(systemName: "star.fill")?
            .withTintColor(.red,
                           renderingMode: .alwaysOriginal)
        
        for _ in 0..<buttonCount {
            let button = UIButton()
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            button.setImage(highlightedStar, for: [.highlighted, .selected])
            button.translatesAutoresizingMaskIntoConstraints = false
//            button.widthAnchor.constraint(equalToConstant: buttonSize.width).isActive = true
//            button.heightAnchor.constraint(equalToConstant: buttonSize.height).isActive = true
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchDown)
            addArrangedSubview(button)
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
            fatalError("The button, \(button), is not in the ratingButtons array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        if selectedRating == rating {
            rating = 0
        } else {
            rating = selectedRating
        }
    }
}
