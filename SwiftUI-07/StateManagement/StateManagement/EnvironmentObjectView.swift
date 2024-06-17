//
//  EnvrionmentObjectView.swift
//  StateManagement
//
//  Created by 조성빈 on 6/17/24.
//

import SwiftUI

class UserProfile: ObservableObject {
    @Published var name: String
    @Published var favoriteProgrammingLanguage: String
    @Published var favoriteColor: Color
    
    init(name: String, favoriteProgrammingLanguage: String, favoriteColor: Color) {
        self.name = name
        self.favoriteProgrammingLanguage = favoriteProgrammingLanguage
        self.favoriteColor = favoriteColor
    }
}

struct EnvironmentObjectView: View {
    @StateObject var profile: UserProfile = UserProfile(name: "조성빈", favoriteProgrammingLanguage: "Swift", favoriteColor: .black)
    @State var isSettingShown = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Form {
                Section {
                    Text("This is just some random data")
                    Text("Let's assume this was the main screen of an app")
                    Text("Tap the cog icon to go to fake settings screen")
                }
            }
            HStack {
                Text("sign in as \(profile.name)")
                    .foregroundStyle(Color(uiColor: UIColor.systemBackground))
                Spacer()
            }
            .padding(30)
            .background(profile.favoriteColor)
        }
        .ignoresSafeArea(edges: .bottom)
        .navigationTitle("@EnvrionmentObject")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: showSetting) {
                    Image(systemName: "gearshape")
                }
            }
        }
        .sheet(isPresented: $isSettingShown) {
            NavigationStack {
                SettingScreen()
            }
        }
    }
    
    func showSetting() {
        isSettingShown.toggle()
    }
}

#Preview {
    NavigationStack {
        EnvironmentObjectView()
    }
}
