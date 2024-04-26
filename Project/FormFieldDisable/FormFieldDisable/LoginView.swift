//
//  LoginView.swift
//  FormFieldDisable
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI

struct LoginView: View {
    @State private var userName: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Text("Dungeons and Wagons")
                .fontWeight(.heavy)
                .foregroundStyle(.blue)
                .font(.largeTitle)
                .padding(.bottom, 30)
            
            Image(systemName: "person.circle")
                .font(.system(size: 150))
                .foregroundStyle(.gray)
                .padding(.bottom, 40)
            
            Group {
                TextField("Username", text: $userName)
                SecureField("Password", text: $password)
            }
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2)
            }
            
            Button(action: {
                print("Login tapped")
            }) {
                Text("Login")
            }
            .padding()
            .background(userName.isEmpty || password.isEmpty ? .gray : .blue)
            .foregroundStyle(.white)
            .clipShape(Capsule())
            .disabled(userName.isEmpty || password.isEmpty)
        }
        .padding()
    }
}

#Preview {
    LoginView()
}
