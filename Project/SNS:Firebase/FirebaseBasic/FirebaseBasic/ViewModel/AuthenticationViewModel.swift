//
//  AuthenticationViewModel.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/29/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn

@Observable
final class AuthenticationViewModel {
    enum State {
        case busy
        case signedIn
        case signedOut
    }
    
    var state: State = .busy
    private var authResult: AuthDataResult? = nil
    var username: String { authResult?.user.displayName ?? "" }
    var email: String { authResult?.user.email ?? "" }
    var pohtoURL: URL? { authResult?.user.photoURL }
    
    func logout() {
        
    }
    
    // 로그인 복구
    func restorePreviousSignIn() {
        
    }
    
    func login() {
        
    }
    
    private func signIn(user: GIDGoogleUser?) async {
        
    }
    
}
