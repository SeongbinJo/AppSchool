//
//  AddJournalViewController.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/13/24.
//

import UIKit

class AddJournalViewController: UIViewController {
    private lazy var mainContainer: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 40
        return stackView
    }()
    
    private lazy var ratingView: UIStackView = {
        let stackView = UIStackView(frame: CGRect(x: 0, y: 0, width: 252, height: 44))
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemCyan
        return stackView
    }()
    
    private lazy var toggleView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        
        let switchComponent = UISwitch()
        let labelComponent = UILabel()
        labelComponent.text = "Switch Label"
        stackView.addArrangedSubview(switchComponent)
        stackView.addArrangedSubview(labelComponent)
        return stackView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "New Entry"
        view.backgroundColor = .white
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(saveEntry))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelEntry))
        
        navigationItem.leftBarButtonItems = [cancelButton]
        navigationItem.rightBarButtonItems = [saveButton]
        
        mainContainer.addArrangedSubview(ratingView)
        mainContainer.addArrangedSubview(toggleView)
        view.addSubview(mainContainer)
        
        let safeArea = view.safeAreaLayoutGuide
        mainContainer.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainContainer.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            mainContainer.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 20),
            mainContainer.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            mainContainer.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            ratingView.widthAnchor.constraint(equalToConstant: 252),
            ratingView.heightAnchor.constraint(equalToConstant: 44)
        ])
    }

    @objc private func saveEntry() {
        
    }
    
    @objc private func cancelEntry() {
        dismiss(animated: true)
    }
}
