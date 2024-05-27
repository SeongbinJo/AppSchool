//
//  ViewController.swift
//  JRNL
//
//  Created by 조성빈 on 5/9/24.
//

import UIKit

class JournalListViewController: UIViewController {
    @IBOutlet var journalTableView: UITableView!
    
    let search = UISearchController(searchResultsController: nil)
    var filteredTableData: [JournalEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedData.shared.loadJournalEntriesData()
        
        search.searchResultsUpdater = self // delegate 역할
        search.obscuresBackgroundDuringPresentation = false // 검색 결과가 나오는 창을 따로 부르는지에 대한 여부
        search.searchBar.placeholder = "Search titles"
        navigationItem.searchController = search
    }

    
    // MARK: - cancel 버튼
    @IBAction func unwindNewEntryCancel(segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - save 버튼
    @IBAction func unwindNewEntrySave(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddJournalEntryViewController,
           let newJournalEntry = sourceViewController.newJournalEntry {
            SharedData.shared.addJournalEntry(newJournalEntry: newJournalEntry)
            SharedData.shared.saveJournalEntriesData()
            journalTableView.reloadData()
        }
    }

}



extension JournalListViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: - UITableView 셀 개수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        SharedData.shared.numberOfJournalEntries()
    }
    
    // MARK: - UITableView 셀 설정
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = journalTableView.dequeueReusableCell(withIdentifier: "journalCell", for: indexPath) as! JournalListTableViewCell // 셀 생성
        let journalEntry = SharedData.shared.getJournalEntry(index: indexPath.row) // 데이터 프로퍼티 생성
        if let photoData = journalEntry.photoData {
            cell.photoImageView.image = UIImage(data: photoData)
        }
        cell.dateLabel.text = journalEntry.dateString
        cell.titleLabel.text = journalEntry.title
        
        return cell
    }
    
    // MARK: - UITableView Delegate
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            SharedData.shared.removeJournalEntry(index: indexPath.row)
            SharedData.shared.saveJournalEntriesData()
            journalTableView.reloadData()
        }
    }
    
    
    // MARK: - 세그웨이 값 전달
    // prepare -> 세그웨이가 작동하여 뷰 이동하기 전에 불림
    // 트리거(현재는 셀-JournalListCell)가 작동하여 지정한 세그웨이(현재는 entryDetail)에 값을 전달하는 부분.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        // 세그웨이 Id 지정
        guard segue.identifier == "entryDetail" else {
            return
        }
        // 목적지 설정
        guard let journalEntryDetailViewController = segue.destination as? JournalEntryDetailTableViewController,
              let selectedJournalEntryCell = sender as? JournalListTableViewCell,
              let indexPath = journalTableView.indexPath(for: selectedJournalEntryCell) else {
            fatalError("Could not get indexPath")
        }
        // 해당 목적지 뷰컨트롤러의 프로퍼티에 전달할 값을 담아줌.
        let selectedJournalEntry = SharedData.shared.getJournalEntry(index: indexPath.row)
        journalEntryDetailViewController.selectedJournalEntry = selectedJournalEntry
    }
    
}


extension JournalListViewController: UISearchResultsUpdating {
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        print(searchBarText)
    }
    
    
}
