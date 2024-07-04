//
//  MapAppApp.swift
//  MapApp
//
//  Created by 조성빈 on 7/4/24.
//

import SwiftUI

@main
struct MapAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
