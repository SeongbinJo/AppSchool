//
//  NoteServiceViewModel.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/29/24.
//

import Firebase
import FirebaseFirestore

class NoteServiceViewModel: ObservableObject {
    @Published var notes: [Note]
        private let dbCollection = Firestore.firestore().collection("notes")
        private var listener: ListenerRegistration?
        
        init(notes: [Note] = []) {
            self.notes = notes
            startRealtimeUpdates()
        }
        
    func fetch() {
//            guard listener == nil else {
//                print("listener가 없음 : \(listener)")
//                return
//            }
            dbCollection.getDocuments { [self] querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                updateNotes(snapshot: snapshot)
                print(notes)
                print("완료.!!")
            }
        }
        
        func addNote(title: String, date: Date, body: String) {
            let note = Note(id: UUID().uuidString, title: title, date: date, body: body)
            _ = try? dbCollection.addDocument(from: note)
            fetch()
        }
        
        private func startRealtimeUpdates() {
            listener = dbCollection.addSnapshotListener { [self] querySnapshot, error in
                guard let snapshot = querySnapshot else {
                    print("Error fetching snapshots: \(error!)")
                    return
                }
                snapshot.documentChanges.forEach { diff in
                    if (diff.type == .added) {
                        print("New note: \(diff.document.data())")
                    }
                    if (diff.type == .modified) {
                        print("Modified note: \(diff.document.data())")
                    }
                    if (diff.type == .removed) {
                        print("Removed note: \(diff.document.data())")
                    }
                }
                updateNotes(snapshot: snapshot)
            }
        }
        
        private func updateNotes(snapshot: QuerySnapshot) {
            let notes: [Note] = snapshot.documents.compactMap { document in
                try? document.data(as: Note.self)
            }
            self.notes = notes.sorted {
                $0.date < $1.date
            }
        }
    
}
