//
//  FormViewController.swift
//  FormWithUIKit
//
//  Created by 조성빈 on 5/23/24.
//

import UIKit

class FormViewController: UIViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    
    let formOneLabel = UILabel()
    let formOneTextField = UITextField()
    let formTwoLabel = UILabel()
    let formTwoTextField = UITextField()
    let resultLabelOne = UILabel()
    let resultLabelTwo = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        setupFormOne()
//        setupFormTwo()
//        setupResults()
        
        view.addSubview(tableView)
        
        // 액션을 add 해주고 뷰가 사라질 때 해제를 해주지 않아 메모리가 쌓이고 누수가 생길 수 있어 잘못된 사용의 예이다.
        // 이렇게 addAction을 할 경우, removeAction을 사용해서 뷰가 사라질때 같이 Action도 제거해주어야한다! (viewDisappear?)
//        formOneTextField.addAction(UIAction(handler: textFieldDidChange), for: .editingChanged)
//        formTwoTextField.addAction(UIAction(handler: textFieldDidChange), for: .editingChanged)
        
        
        // weak를 사용하여 약한 참조로 인해 ARC가 도움을 줘 알아서 메모리를 정리? 해준다. addAction의 올바른 예이다.
        formOneTextField.addAction(UIAction { [weak self] action in
            self?.textFieldDidChange(action)
        }, for: .editingChanged)
        formTwoTextField.addAction(UIAction { [weak self] action in
            self?.textFieldDidChange(action)
        }, for: .editingChanged)
    }
    
    func setupFormOne() {
        formOneLabel.text = "이것은 첫 번째 폼입니다"
        formOneLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formOneLabel)
        
        formOneTextField.borderStyle = .roundedRect
        formOneTextField.placeholder = "여기에 입력하세요"
        formOneTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formOneTextField)
        
        NSLayoutConstraint.activate([
            formOneLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            formOneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formOneTextField.topAnchor.constraint(equalTo: formOneLabel.bottomAnchor, constant: 10),
            formOneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formOneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
    }
    
    func setupFormTwo() {
        formTwoLabel.text = "이것은 두 번째 폼입니다"
        formTwoLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formTwoLabel)
        
        formTwoTextField.borderStyle = .roundedRect
        formTwoTextField.placeholder = "여기에 입력하세요"
        formTwoTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(formTwoTextField)
        
        NSLayoutConstraint.activate([
            formTwoLabel.topAnchor.constraint(equalTo: formOneTextField.bottomAnchor, constant: 20),
            formTwoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formTwoTextField.topAnchor.constraint(equalTo: formTwoLabel.bottomAnchor, constant: 10),
            formTwoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            formTwoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    func setupResults() {
        resultLabelOne.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabelOne)
        
        resultLabelTwo.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(resultLabelTwo)
        
        NSLayoutConstraint.activate([
            resultLabelOne.topAnchor.constraint(equalTo: formTwoTextField.bottomAnchor, constant: 20),
            resultLabelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            resultLabelTwo.topAnchor.constraint(equalTo: resultLabelOne.bottomAnchor, constant: 10),
            resultLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
        ])
    }
    
    func textFieldDidChange(_ action: UIAction) {
            guard let textField = action.sender as? UITextField else { return }
            
            if textField == formOneTextField {
                resultLabelOne.text = "폼 #1 = \(textField.text ?? "")"
            } else {
                resultLabelTwo.text = "폼 #2 = \(textField.text ?? "")"
            }
        }
}


extension FormViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        return cell
    }
    
    
}
