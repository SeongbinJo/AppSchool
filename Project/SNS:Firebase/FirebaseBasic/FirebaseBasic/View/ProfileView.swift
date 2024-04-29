//
//  ProfileView.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/29/24.
//

import SwiftUI

struct ProfileView: View {
    var authenticationVM: AuthenticationViewModel
    
    var body: some View {
        VStack {
            AsyncImage(url: authenticationVM.pohtoURL) { image in
                image
                    .resizable()
                    .clipShape(Circle())
            } placeholder: {
                ProgressView()
            }
            .frame(width: 100, height: 100)
            Text("User: \(authenticationVM.username)")
                .foregroundStyle(.black)
            Text("Email: \(authenticationVM.email)")
                .foregroundStyle(.black)
            Button("Logout") {
                authenticationVM.logout()
            }
            .buttonStyle(.borderedProminent)
            .frame(width: 150, height: 50)
        }

    }
}

#Preview {
    ProfileView(authenticationVM: AuthenticationViewModel())
}
