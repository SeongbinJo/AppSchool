import UIKit
import PlaygroundSupport

class TableViewExampleController: UIViewController {
    var tableView: UITableView?
    var journalEntries: [[String]] = [
    ["sun.max", "9 Apr 2023", "Nice weather today"],
    ["cloud.rain", "10 Apr 2023", "Heavy rain today"],
    ["cloud.sun", "11 Apr 2023", "It's cloudy out"],
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.bounds = CGRect(x: 0, y: 0, width: 375, height: 667)
        createTableView()
    }
    
    func createTableView() {
        self.tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        self.tableView?.dataSource = self
        self.tableView?.delegate = self
        self.tableView?.backgroundColor = .white
        self.tableView?.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(self.tableView!)
    }
    
}


extension TableViewExampleController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        journalEntries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let journalEntry = journalEntries[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.image = UIImage(systemName: journalEntry[0])
        content.text = journalEntry[1]
        content.secondaryText = journalEntry[2]
        cell.contentConfiguration = content
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let selectedJournalEntry = journalEntries[indexPath.row]
        print(selectedJournalEntry)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            journalEntries.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}

PlaygroundPage.current.liveView = TableViewExampleController()
