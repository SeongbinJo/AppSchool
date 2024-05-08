//
//  ContentView.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/29/24.
//

import SwiftUI
import GoogleSignInSwift

struct ContentView: View {
    @State var authenticationVM: AuthenticationViewModel = AuthenticationViewModel()
    
    var body: some View {
//        ZStack {
//            Color.white.ignoresSafeArea()
//            switch authenticationVM.state {
//            case .busy:
//                ProgressView() // 로딩.
//            case .signedIn:
//                ProfileView(authenticationVM: authenticationVM)
//            case .signedOut:
//                GoogleSignInButton(action: authenticationVM.login)
//                    .frame(width: 150, height: 30, alignment: .center)
//            }
//        }
//        .task {
//            authenticationVM.restorePreviousSignIn()
//        }
        NoteListView()
    }
}

#Preview {
    ContentView()
}
