//
//  ContentView.swift
//  RemoteConfig
//
//  Created by Jungman Bae on 4/29/24.
//

import SwiftUI
import Firebase
import FirebaseRemoteConfigSwift

class RemoteConfiguration {
    private var remoteConfig = Firebase.RemoteConfig.remoteConfig()
    
    init() {
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0 // 서버로부터 가져오는 주기 설정
        remoteConfig.configSettings = settings
    }
    
    private func activate() {
        remoteConfig.activate { changed, error in
            guard error == nil else {
                print("Error activating Remote Config : \(error!.localizedDescription)")
                return
            }
            print("Default values were \(changed ? "YES" : "NO") updated from Remote Config")
        }
    }
    
    func fetchFromServer() async {
        guard let status = try? await remoteConfig.fetch(), status == .success else {
            print("Couldn't fetch Remote Config")
            return
        }
        print("Remote Config successfully fetched")
        activate()
    }
    
    func registerForRealTimeUpdates() {
        print("Registering for Remote Config realtime updates")
        remoteConfig.addOnConfigUpdateListener { [self] update, error in
            guard let update, error == nil else {
                print("Error listening for Remote Config realtime updates: \(error)")
                return
            }
            print("Updated keys in realtime: \(update)")
            activate()
        }
    }
}


struct ContentView: View {
    private var config = RemoteConfiguration()
    @RemoteConfigProperty(key: "screenType", fallback: nil) var screenType: String?
    
    private var image: (name: String, color: Color) {
        if screenType == "screenA" {
            ("a.square", .green)
        }else if screenType == "screenB" {
            ("b.square", .blue)
        }else {
            ("questinomark.square", .red)
        }
    }
    
    var body: some View {
        VStack {
            if screenType != nil {
                Image(systemName: image.name)
                    .foregroundStyle(image.color)
                    .font(.system(size: 250))
            }else {
                ProgressView()
                    .controlSize(.large)
            }
        }
        .task {
            await config.fetchFromServer()
            config.registerForRealTimeUpdates()
        }
    }
}

#Preview {
    ContentView()
}
