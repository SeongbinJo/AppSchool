//
//  LifeCycleDemoApp.swift
//  LifeCycleDemo
//
//  Created by 조성빈 on 4/19/24.
//

import SwiftUI

@main
struct LifeCycleDemoApp: App {
    
    // 앱 실행상황 씬 상태
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { oldValue, newValue in
            switch newValue {
            case .active:
                print("Active \(oldValue)")
            case .inactive:
                print("InActive \(oldValue)")
            case .background:
                print("Background")
            default:
                print("Unknown scenePhase")
            }
        }
    }
}
