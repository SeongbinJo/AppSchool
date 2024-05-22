//
//  TouchGestureViewController.swift
//  GestureWithUIKit
//
//  Created by 조성빈 on 5/21/24.
//

import UIKit

class TouchGestureViewController: UIViewController {
    
    override func viewDidLoad() {
            super.viewDidLoad()
            
            let menuButton = UIButton(type: .system)
            var conf = UIButton.Configuration.filled()
            conf.title = "Options"
            menuButton.configuration = conf
            menuButton.addAction(UIAction { [weak self] _ in
                self?.showMenu(sourceView: menuButton)
            }, for: .touchUpInside)
            menuButton.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(menuButton)
            NSLayoutConstraint.activate([
                menuButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                menuButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            ])
        }

        func showMenu(sourceView: UIView) {
            let alert = UIAlertController(title: "Options", message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Open", style: .default) { _ in
                self.showMessage("Open chosen")
            })
            alert.addAction(UIAlertAction(title: "Find", style: .default, handler: { _ in self.showMessage("Find chosen") }))
            alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { _ in self.showMessage("Delete chosen") }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "Submenu", style: .default, handler: { [weak self] _ in
                self?.showSubmenu(sourceView: sourceView)
            }))


            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = sourceView
                popoverController.sourceRect = sourceView.bounds
                popoverController.permittedArrowDirections = [.down]
            }
            
            present(alert, animated: true)
        }
        
        func showSubmenu(sourceView: UIView) {
            let submenuAlert = UIAlertController(title: "Submenu", message: nil, preferredStyle: .actionSheet)
            submenuAlert.addAction(UIAlertAction(title: "Copy Format", style: .default, handler: { _ in self.showMessage("Copy format chosen") }))
            submenuAlert.addAction(UIAlertAction(title: "Paste Format", style: .default, handler: { _ in self.showMessage("Paste format chosen") }))
            submenuAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            
            // 아이패드에서 팝오버 형태로 서브메뉴 표시
            if let popoverController = submenuAlert.popoverPresentationController {
                popoverController.sourceView = sourceView
                popoverController.sourceRect = sourceView.bounds
                popoverController.permittedArrowDirections = [.up]
            }
            
            present(submenuAlert, animated: true, completion: nil)
        }
        
        func showMessage(_ message: String) {
            let alert = UIAlertController(title: message, message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
}
