//
//  ViewController.swift
//  ContextMenuWithUIKit
//
//  Created by 조성빈 on 5/22/24.
//

import UIKit

class ViewController: UIViewController {
    private lazy var rectangle: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 100, y: 100, width: 200, height: 200)
        
        let contextMenu = UIContextMenuInteraction(delegate: self)
        view.addInteraction(contextMenu)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(rectangle)
    }


}

extension ViewController: UIContextMenuInteractionDelegate {
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            let redAction = UIAction(title: "빨강", image: nil) { _ in
                interaction.view?.backgroundColor = .red
            }
            let blueAction = UIAction(title: "파랑", image: nil) { _ in
                interaction.view?.backgroundColor = .blue
            }
            let purpleAction = UIAction(title: "보라", image: nil) { _ in
                interaction.view?.backgroundColor = .purple
            }
            
            let colorMenu = UIMenu(title: "색상", options: .displayInline, children: [redAction, blueAction])
            let otherMenu = UIMenu(title: "쩌리메뉴", options: .displayInline, children: [purpleAction])
            
            return UIMenu(title: "", children: [colorMenu, otherMenu])
        }
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configuration: UIContextMenuConfiguration, highlightPreviewForItemWithIdentifier identifier: any NSCopying) -> UITargetedPreview? {
        guard let view = interaction.view else { return nil }
        return UITargetedPreview(view: view)
    }
    
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, willPerformPreviewActionForMenuWith configuration: UIContextMenuConfiguration, animator: any UIContextMenuInteractionCommitAnimating) {
        if let view = interaction.view {
            let transition = CATransition()
            transition.type = .fade
            transition.duration = 0.2
            view.layer.add(transition, forKey: nil)
        }
    }
}
