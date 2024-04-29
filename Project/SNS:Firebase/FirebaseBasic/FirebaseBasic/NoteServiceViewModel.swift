//
//  NoteService.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/29/24.
//

import Firebase
import FirebaseFirestore

class NoteServiceViewModel: ObservableObject {
    @Published var notes: [Note]
    private var dbCollection = Firestore.firestore().collection("notes")
    private var listner: ListenerRegistration?
    
    init(notes: [Note] = []) {
        self.notes = notes
        startRealtimeUpdate()
    }
    
    func fetch() {
        guard listner == nil else { return }
        dbCollection.getDocuments { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshots: \(error!)")
                return
            }
            updateNote(snapshot: snapshot)
        }
    }
    
    func addNote(title: String, date: Date, body: String) {
        let note = Note(id: UUID().uuidString, title: title, date: date, body: body)
        _ = try? dbCollection.addDocument(from: note)
        fetch()
    }
    
    
    private func startRealtimeUpdate() {
        listner = dbCollection.addSnapshotListener { [self] querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error fetching snapshot: \(error!)")
                return
            }
            snapshot.documentChanges.forEach { diff in
//                if diff.type == .added {
//                    print("New note: \(diff.document.data())")
//                }
//                if diff.type == .modified {
//                    print("Modified note: \(diff.document.data())")
//                }
//                if diff.type == .removed {
//                    print("Removed note: \(diff.document)")
//                }
                switch diff.type {
                case .added:
                    print("New note: \(diff.document.data())")
                case .modified:
                    print("Modified note: \(diff.document.data())")
                case .removed:
                    print("Removed note: \(diff.document)")
                }
            }
            updateNote(snapshot: snapshot)
        }
    }
    
    private func updateNote(snapshot: QuerySnapshot) {
        let notes: [Note] = snapshot.documents.compactMap{ document in
            try? document.data(as: Note.self) // data(as: ) 는 codable 프로토콜을 지키는 구조체여야만 한다.
        }
        self.notes = notes.sorted { $0.date < $1.date }
    }
}
