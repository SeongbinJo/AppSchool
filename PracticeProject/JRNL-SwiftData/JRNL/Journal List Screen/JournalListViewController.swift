//
//  ViewController.swift
//  JRNL
//
//  Created by Jungman Bae on 5/7/24.
//

import UIKit
import SwiftData

class JournalListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating {
    // MARK: - Properties
    @IBOutlet var collectionView: UICollectionView!
    let search = UISearchController(searchResultsController: nil)
    
    var journalEntries: [JournalEntry] = []
    var filteredTableData: [JournalEntry] = []
    
    var container: ModelContainer?
    var context: ModelContext?
    let descrptor = FetchDescriptor<JournalEntry>(sortBy: [SortDescriptor<JournalEntry>(\.dateString)])

    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let _container = try? ModelContainer(for: JournalEntry.self) else {
            fatalError("Could not initialize Container")
        }
        container = _container
        context = ModelContext(_container)
        
        fetchJournalEntries()
        
        setupCollectionView()
        
        search.searchResultsUpdater = self
        search.obscuresBackgroundDuringPresentation = false
        search.searchBar.placeholder = "Search titles"
        navigationItem.searchController = search
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    func setupCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = flowLayout
    }

    // MARK: - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if search.isActive {
            return self.filteredTableData.count
        } else {
            return self.journalEntries.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let journalCell = collectionView.dequeueReusableCell(withReuseIdentifier: "journalCell", for: indexPath) as! JournalListCollectionViewCell
        
        let journalEntry: JournalEntry
        if self.search.isActive {
            journalEntry = filteredTableData[indexPath.row]
        } else {
            journalEntry = journalEntries[indexPath.row]
        }
        
        if let photoData = journalEntry.photoData {
            journalCell.photoImageView.image = UIImage(data: photoData)
        }        
        journalCell.dateLabel.text = journalEntry.dateString
        journalCell.titleLabel.text = journalEntry.entryTitle
        return journalCell
    }
    
    // MARK: - UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (elements) -> UIMenu? in
            let delete = UIAction(title: "Delete") { [weak self] (action) in
                if let search = self?.search, search.isActive,
                   let selectedJournalEntry = self?.filteredTableData[indexPath.item] {
                    self?.filteredTableData.remove(at: indexPath.item)
                    self?.context?.delete(selectedJournalEntry)
                } else {
                    if let selectedJournalEntry = self?.journalEntries[indexPath.item] {
                        self?.journalEntries.remove(at: indexPath.row)
                        self?.context?.delete(selectedJournalEntry)
                    }
                }
                collectionView.reloadData()
            }
            return UIMenu(title: "", image: nil, identifier: nil, options: [], children: [delete])
        }
        return config
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var columns: CGFloat
        if (traitCollection.horizontalSizeClass == .compact) {
            columns = 1
        } else {
            columns = 2
        }
        let viewWidth = collectionView.frame.width
        let inset = 10.0
        let contentWidth = viewWidth - inset * (columns + 1)
        let cellWidth = contentWidth / columns
        let cellHeight = 90.0
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    // MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchBarText = searchController.searchBar.text else {
            return
        }
        filteredTableData.removeAll()
//        for journalEntry in SharedData.shared.getAllJournalEntries() {
//            if journalEntry.entryTitle.lowercased().contains(searchBarText.lowercased()) {
//                filteredTableData.append(journalEntry)
//            }
//        }
        filteredTableData = journalEntries.filter { journalEntry in
            journalEntry.entryTitle.lowercased().contains(searchBarText.lowercased())
        }
        self.collectionView.reloadData()
    }
    
    // MARK: - Methods
    func fetchJournalEntries() {
        if let journalEntries = try? context?.fetch(descrptor) {
            self.journalEntries = journalEntries
        }
    }
    
    @IBAction func unwindNewEntryCancel(segue: UIStoryboardSegue) {

    }
    @IBAction func unwindNewEntrySave(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? AddJournalEntryViewController,
           let newJournalEntry = sourceViewController.newJournalEntry {
            self.context?.insert(newJournalEntry)
            fetchJournalEntries()
            collectionView.reloadData()
        } else {
            print("No Entry or Controller")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard segue.identifier == "entryDetail" else {
            return
        }
        guard let journalEntryDetailViewController = segue.destination as? JournalEntryDetailViewController,
              let selectedJournalEntryCell = sender as? JournalListCollectionViewCell,
              let indexPath = collectionView.indexPath(for: selectedJournalEntryCell) else {
            fatalError("Could not get indexPath")
        }
        let selectedJournalEntry: JournalEntry
        if self.search.isActive {
            selectedJournalEntry = filteredTableData[indexPath.row]
        } else {
            selectedJournalEntry = journalEntries[indexPath.row]
        }
        journalEntryDetailViewController.selectedJournalEntry = selectedJournalEntry
    }

}

