//
//  AuthenticationViewModel.swift
//  FirebaseBasic
//
//  Created by 조성빈 on 4/29/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore

extension UIApplication {
    static var currentRootViewController: UIViewController? {
        UIApplication.shared.connectedScenes
            .filter({ $0.activationState == .foregroundActive })
            .map({ $0 as? UIWindowScene })
            .compactMap({ $0 })
            .first?.windows
            .filter({ $0.isKeyWindow })
            .first?
            .rootViewController
    }
}

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
        // 구글 로그아웃
        GIDSignIn.sharedInstance.signOut()
        GIDSignIn.sharedInstance.disconnect()
        // 파베 로그아웃
        try? Auth.auth().signOut()
        
        authResult = nil
        state = .signedOut
    }
    
    // 로그인 복구
    func restorePreviousSignIn() {
        GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
            if let error {
                print("Error: \(error.localizedDescription)")
            }
            Task {
                await self.signIn(user: user)
            }
        }
    }
    
    func login() {
        state = .busy
                guard let clientID = FirebaseApp.app()?.options.clientID,
                      let rootViewController = UIApplication.currentRootViewController else {
                    return
                }
                let configuration = GIDConfiguration(clientID: clientID)
                GIDSignIn.sharedInstance.configuration = configuration
                GIDSignIn.sharedInstance.signIn(withPresenting: rootViewController, hint: nil) { result, error in
                    if let error { print("Error: \(error.localizedDescription)")}
                    Task {
                        await self.signIn(user: result?.user)
                    }
                }
    }
    
    private func signIn(user: GIDGoogleUser?) async {
        guard let user, let idToken = user.idToken else {
                    state = .signedOut
                    return
                }
                
                let credential = GoogleAuthProvider.credential(withIDToken: idToken.tokenString,
                                                               accessToken: user.accessToken.tokenString)
                
                do {
                    authResult = try await Auth.auth().signIn(with: credential)
                    state = .signedIn
                } catch {
                    state = .signedOut
                    print("Error: \(error.localizedDescription)")
                }
    }
    
}
