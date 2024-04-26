//
//  SignUpView.swift
//  SignUp
//
//  Created by 조성빈 on 4/26/24.
//

import SwiftUI

struct Address {
    var street: String = ""
    var city: String = ""
    var postCode: String = ""
}

struct SignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var address: Address = Address()
    @State private var prevAddress: Address = Address()
    @State private var lessThenTwo: Bool = false
    @State private var userName: String = ""
    @State private var password: String = ""
    @State private var userNameErrorMessage: String = ""
    
    var body: some View {
        NavigationStack {
            Form {
                Section("이름") {
                    TextField("성", text: $firstName)
                    TextField("이름", text: $lastName)
                }
                
                Section("현주소") {
                    TextField("도로명", text: $address.street)
                    TextField("도시", text: $address.city)
                    TextField("우편번호", text: $address.postCode)
                    Toggle(isOn: $lessThenTwo) {
                        Text("2년 이상 거주하였습니까?")
                    }
                }
                
                if !lessThenTwo {
                    Section("이전 거주지") {
                        TextField("도로명", text: $prevAddress.street)
                        TextField("도시", text: $prevAddress.city)
                        TextField("우편번호", text: $prevAddress.postCode)
                    }
                }
                
                Section {
                    TextField("사용할 이름을 입력하세요.", text: $userName)
                    if !userNameErrorMessage.isEmpty {
                        Text(userNameErrorMessage)
                            .font(.caption)
                            
                    }
                    SecureField("사용할 비밀번호를 입력하세요.", text: $password)
                }
                
                Button(action: {
                    userNameErrorMessage = "사용할 이름을 입력하세요."
                    print("가입하기 -> 클릭")
                }) {
                    Text("가입하기")
                }
            }
        }
    }
}

#Preview {
    SignUpView()
}
