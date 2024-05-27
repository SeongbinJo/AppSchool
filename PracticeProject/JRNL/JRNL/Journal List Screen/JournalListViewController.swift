//
//  ViewController.swift
//  JRNL
//
//  Created by 조성빈 on 5/9/24.
//

import UIKit

class JournalListViewController: UIViewController {
    @IBOutlet var journalCollectionView: UICollectionView!
    
    
    let search = UISearchController(searchResultsController: nil)
    var filteredTableData: [JournalEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SharedData.shared.loadJournalEntriesData()
        
        setupCollectionView()
        
        search.searchResultsUpdater = self // delegate 역할
        search.obscuresBackgroundDuringPresentation = false // 검색 결과가 나오는 창을 따로 부르는지에 대한 여부
        search.searchBar.placeholder = "Search titles"
        navigationItem.searchController = search
    }
    
    // 화면 회전시 콜렉션 뷰의 셀들의 위치를 다시 잡아줌
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        journalCollectionView.collectionViewLayout.invalidateLayout()
    }

    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // 각 셀의 여백 정의
        flowLayout.minimumInteritemSpacing = 0 // 각 셀의 좌우 간격
        flowLayout.minimumLineSpacing = 10 // 각 셀의 위아래 줄 간격
        journalCollectionView.collectionViewLayout = flowLayout
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
            journalCollectionView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "entryDetail" else {
            return
        }
        guard let journalEntryDetailTableViewController = segue.destination as? JournalEntryDetailTableViewController,
              let selectedJournalEntryCell = sender as? JournalListCollectionViewCell,
              let indexPath = journalCollectionView.indexPath(for: selectedJournalEntryCell) else {
            fatalError("Could not get indexPath")
        }
        let selectedJournalEntry: JournalEntry
        if self.search.isActive {
            selectedJournalEntry = filteredTableData[indexPath.row]
        } else {
            selectedJournalEntry = SharedData.shared.getJournalEntry(index: indexPath.row)
        }
        journalEntryDetailTableViewController.selectedJournalEntry = selectedJournalEntry
    }

}

extension JournalListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if search.isActive {
            return self.filteredTableData.count
        }else {
            return SharedData.shared.numberOfJournalEntries()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let journalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "journalCell", for: indexPath) as! JournalListCollectionViewCell
        let journalEntry: JournalEntry
        if self.search.isActive {
            journalEntry = filteredTableData[indexPath.row]
        }else {
            journalEntry = SharedData.shared.getJournalEntry(index: indexPath.row)
        }
        
        if let photoData = journalEntry.photoData {
            journalCell.photoImageView.image = UIImage(data: photoData)
        }
        journalCell.dateLabel.text = journalEntry.dateString
        journalCell.titleLabel.text = journalEntry.title
        
        return journalCell
    }
    
    // 테이블 뷰의 editingStyle과 비슷
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete") { [weak self] (action) in
                if let search = self?.search.isActive, let selectedJournalEntry = self?.filteredTableData[indexPath.row] {
                    self?.filteredTableData.remove(at: indexPath.row)
                    SharedData.shared.removeSelectedJournalEntry(selectedJournalEntry)
                }else {
                    SharedData.shared.removeJournalEntry(index: indexPath.row)
                }
                SharedData.shared.saveJournalEntriesData()
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        return config
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var columns: CGFloat
        if (traitCollection.horizontalSizeClass == .compact) { // 화면의 가로 사이즈가 .compact(작냐)한지 .large(큰지)
            columns = 1
        }else {
            columns = 2
        }
        let viewWidth = collectionView.frame.width
        let inset = 10.0
        let contentWidth = viewWidth - inset * (columns + 1)
        let cellWidth = contentWidth / columns
        let cellHeight = 90.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
}


extension JournalListViewController: UISearchResultsUpdating {
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        print(searchBarText)
        filteredTableData.removeAll()
        for journalEntry in SharedData.shared.getAllJournalEntries() {
            if journalEntry.title!.lowercased().contains(searchBarText.lowercased()) {
                filteredTableData.append(journalEntry)
            }
        }
        self.journalCollectionView.reloadData()
    }
    
    
}
