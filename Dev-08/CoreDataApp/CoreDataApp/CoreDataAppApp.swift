//
//  CoreDataAppApp.swift
//  CoreDataApp
//
//  Created by 조성빈 on 7/2/24.
//

import SwiftUI

@main
struct CoreDataAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
