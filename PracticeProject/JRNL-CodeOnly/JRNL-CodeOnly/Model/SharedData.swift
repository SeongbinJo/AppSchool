//
//  SharedData.swift
//  JRNL-CodeOnly
//
//  Created by 조성빈 on 5/16/24.
//

import UIKit

class SharedData {
    static let shared = SharedData()
    private var journalEntries: [JournalEntry]
    
    // 생성자에 private을 사용함으로 외부에서 SharedData() 생성 불가.
    private init() {
        journalEntries = []
    }
    
    func numberOfJournalEntries() -> Int {
        return journalEntries.count
    }
    
    func getJournalEntry(index: Int) -> JournalEntry {
        return journalEntries[index]
    }
    
    func getAllJournalEntries() -> [JournalEntry] {
        let wholeJournalEntries = journalEntries
        return wholeJournalEntries
    }
    
    func addJournalEntry(newJournalEntry: JournalEntry) {
        journalEntries.append(newJournalEntry)
    }
    
    func removeJournalEntry(index: Int) {
        journalEntries.remove(at: index)
    }
    
    
}
