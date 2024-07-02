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
        persistentContainer = NSPersistentContainer(name: "CoreDataApp") // 코어데이터의 이름인 CoreDataApp 사용
        persistentContainer.loadPersistentStores { (description, error) in
            if let error = error {
                fatalError("Core Data failed to initialize \(error.localizedDescription)")
            }
            
        }
    }
}
