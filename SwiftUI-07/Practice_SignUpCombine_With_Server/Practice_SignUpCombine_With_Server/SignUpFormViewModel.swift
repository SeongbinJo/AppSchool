//
//  SignUpViewModel.swift
//  Practice_SignUpCombine_With_Server
//
//  Created by 조성빈 on 6/19/24.
//

import Foundation
import Combine

class SignUpFormViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var usernameMessage: String = ""
    
    @Published var isValid: Bool = false
    
    @Published var showUpdateDialog: Bool = false
}
