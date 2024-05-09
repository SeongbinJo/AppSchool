//
//  ViewController.swift
//  JRNL
//
//  Created by 조성빈 on 5/9/24.
//

import UIKit

class JournalListViewController: UIViewController {
    @IBOutlet var journalTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}



extension JournalListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath)
        
        return cell
    }
    
    
}
