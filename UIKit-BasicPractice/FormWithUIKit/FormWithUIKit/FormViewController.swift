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
    let formOneSwitch = UISwitch()
    let formTwoLabel = UILabel()
    let formTwoTextField = UITextField()
    let resultLabelOne = UILabel()
    let resultLabelTwo = UILabel()
    let resultButton = UIButton(type: .system)
    
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
    
    func setupFormOne(view: UIView, indexPath: IndexPath) {
        if indexPath.section != 0 { return }
        switch indexPath.row {
        case 0:
            formOneLabel.text = "이것은 첫 번째 폼입니다"
            formOneLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formOneLabel)
            NSLayoutConstraint.activate([
                formOneLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formOneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])
            
        case 1:
            formOneTextField.borderStyle = .roundedRect
            formOneTextField.placeholder = "여기에 입력하세요"
            formOneTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formOneTextField)
            NSLayoutConstraint.activate([
                formOneTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formOneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                formOneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        case 2:
            formOneSwitch.translatesAutoresizingMaskIntoConstraints = false
            formOneSwitch.addAction(UIAction { [weak self] _ in
                self?.tableView.reloadData()
            }, for: .valueChanged)
            view.addSubview(formOneSwitch)
            NSLayoutConstraint.activate([
                formOneSwitch.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                formOneSwitch.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        default:
            break
        }
    }
    
    func setupFormTwo(view: UIView, indexPath: IndexPath) {
        if indexPath.section != 1 { return }
        switch indexPath.row {
        case 0:
            formTwoLabel.text = "이것은 두 번째 폼입니다"
            formTwoLabel.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formTwoLabel)
            NSLayoutConstraint.activate([
                formTwoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formTwoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            ])
            
        case 1:
            formTwoTextField.borderStyle = .roundedRect
            formTwoTextField.placeholder = "여기에 입력하세요"
            formTwoTextField.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(formTwoTextField)
            NSLayoutConstraint.activate([
                formTwoTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                formTwoTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                formTwoTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
            ])
        default:
            break
        }
    }
    
    func setupResults(view: UIView, indexPath: IndexPath) {
        if indexPath.section != 2 { return }
        switch indexPath.row {
        case 0:
            resultLabelOne.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(resultLabelOne)
            NSLayoutConstraint.activate([
                resultLabelOne.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                resultLabelOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            ])
            
        case 1:
            resultLabelTwo.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(resultLabelTwo)
            NSLayoutConstraint.activate([
                resultLabelTwo.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                resultLabelTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16)
            ])
        case 2:
            resultButton.translatesAutoresizingMaskIntoConstraints = false
            resultButton.setTitle("result button", for: .normal)
            resultButton.isHighlighted = formOneSwitch.isOn ? false : true
            view.addSubview(resultButton)
            NSLayoutConstraint.activate([
                resultButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                resultButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        default:
            break
        }
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
        switch section {
        case 0:
            return 3
        case 1:
            return formOneSwitch.isOn ? 2 : 0
        case 2:
            return 3
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 2 {
            return "결과"
        }
        return nil
    }
    
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch section {
        case 0:
            return "폼 #1"
        case 1:
            return formOneSwitch.isOn ? "폼 #2" : nil
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        // 셀의 contentView의 subView에 그려져있는 것들을 Superview에서 지워줌. => 재사용셀이 깔끔해진 채로 재사용됨.
        cell.contentView.subviews.forEach({ view in view.removeFromSuperview() })
        
        switch indexPath.section {
        case 0:
            setupFormOne(view: cell.contentView, indexPath: indexPath)
        case 1:
            setupFormTwo(view: cell.contentView, indexPath: indexPath)
        case 2:
            setupResults(view: cell.contentView, indexPath: indexPath)
        default:
            break
        }
        return cell
    }
    
    
}
