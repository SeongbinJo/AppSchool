//
//  CoreDataManager.swift
//  CoreDataApp
//
//  Created by 조성빈 on 7/2/24.
//

import Foundation
import CoreData

class CoreDataManager {
    let persistentContainer: NSPersistentContainer
    init() {
        persistentContainer = NSPersistentContainer(name: "CoreDataApp") // CoreDataApp 이라는 DB(코어데이터)를 초기화
        persistentContainer.loadPersistentStores { (description, error) in // 초기화된 컨테이너에 데이터들을 load하는 부분. -> 데이터를 가져오는 부분이라 비동기로 처리.
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
        }
    }
    
    // Create
    func savePet(name: String, breed: String) {
        let pet = Animal(context: persistentContainer.viewContext)
        pet.name = name
        pet.breed = breed
        do {
            try persistentContainer.viewContext.save()
            print("Pet saved!")
        } catch {
            print("Failed to save pet \(error)")
        }
    }
    
    // Read (List)
    func getAllPets() -> [Animal] {
        let fetchRequest: NSFetchRequest<Animal> = Animal.fetchRequest()
        do {
            return try persistentContainer.viewContext.fetch(fetchRequest)
        } catch {
            return []
        }
        
    }
    
    // Delete
    func deletePet(animal: Animal) {
        persistentContainer.viewContext.delete(animal)
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Failed to save context \(error.localizedDescription)")
        }
    }
}
