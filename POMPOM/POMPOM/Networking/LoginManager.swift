//
//  LoginManager.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/09.
//

import Foundation
import AuthenticationServices
import FirebaseCore
import CryptoKit
import FirebaseAuth
import GoogleSignIn


import SwiftUI

class LoginManager {
    static let shared = LoginManager()
    
    var currentUser: User? {
        Auth.auth().currentUser
    }
    
    var uid: String? {
        Auth.auth().currentUser?.uid
    }
    
    //로그인 여부 -> Bool 값 리턴
    var isLogin: Bool {
        currentUser != nil
    }
    
    func signInFirebase(with credential: AuthCredential) {
        // Sign in with Firebase.
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if (error != nil) {
                // Error. If error.code == .MissingOrInvalidNonce, make sure
                // you're sending the SHA256-hashed nonce as a hex string with
                // your request to Apple.
                print(error?.localizedDescription)
                return
            }
        }
    }
    
    
    //로그아웃 메서드.
    func logOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
    //회원탈퇴 메서드
    func signOut() {
        currentUser?.delete { error in
            if let error = error {
                print("DEBUG: 회원탈퇴 에러 - \(error.localizedDescription)")
            } else {
                print("DEBUG: 회원탈퇴 성공")
            }
        }
    }
}

//MARK: - 구글 로그인
class SignInWithGoogleObject: NSObject {
    public func signWithGoogle() {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        guard let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController else {return}
        let config = GIDConfiguration(clientID: clientID)
        // Start the sign in flow!
        GIDSignIn.sharedInstance.signIn(with: config, presenting: presentingViewController) { user, error in
            if let error = error {
                print("DEBUG: 구글 로그인 에러 - \(error.localizedDescription)")
                return
            }
            guard let authentication = user?.authentication, let idToken = authentication.idToken else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: authentication.accessToken)
            LoginManager.shared.signInFirebase(with: credential)
        }
    }
}

//MARK: - 애플 로그인
class SignInWithAppleObject: NSObject {
    private var currentNonce: String?
    
    public func signInWithApple() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email, .fullName] //이메일과 풀네임을 요청함.
        
        //noce 값 생성
        let noce = randomNonceString()
        currentNonce = noce
        request.nonce = sha256(currentNonce!)
        
        //Apple ID 로그인 요쳥.
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
    
    // 요청 암호화
    // Adapted from https://auth0.com/docs/api-auth/tutorials/nonce#generate-a-cryptographically-random-nonce
    private func randomNonceString(length: Int = 32) -> String {
        precondition(length > 0)
        let charset: [Character] =
        Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remainingLength = length
        
        while remainingLength > 0 {
            let randoms: [UInt8] = (0 ..< 16).map { _ in
                var random: UInt8 = 0
                let errorCode = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
                if errorCode != errSecSuccess {
                    fatalError(
                        "Unable to generate nonce. SecRandomCopyBytes failed with OSStatus \(errorCode)"
                    )
                }
                return random
            }
            
            randoms.forEach { random in
                if remainingLength == 0 {
                    return
                }
                
                if random < charset.count {
                    result.append(charset[Int(random)])
                    remainingLength -= 1
                }
            }
        }
        
        return result
    }
    @available(iOS 13, *)
    private func sha256(_ input: String) -> String {
        let inputData = Data(input.utf8)
        let hashedData = SHA256.hash(data: inputData)
        let hashString = hashedData.compactMap {
            String(format: "%02x", $0)
        }.joined()
        
        return hashString
    }
}

@available(iOS 13, *)
extension SignInWithAppleObject: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        //1. 인증 객체가 성공적으로 리턴되었는지 확인하기위해 credential 이 존재하는 지 확인
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            //2.  3가지 상태를 체크
            //2-1 : 리턴받은 nonce 값이 우리가 가지고 있는 로컬 nonce 값과 일치하는지 체크
            guard let nonce = currentNonce else {
                print("Invalide state: A login callback was recieved, but no login request was sent")
                return
            }
            //2-2 : credential 이 identityToken 을 갖고 있는지 확인
            guard let appleIDToken = appleIDCredential.identityToken else {
                print("Unable to fetch identity token")
                return
            }
            //2-3 : 이 JWT 토큰이 String 으로 변환이 되는지를 확인.
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                print("Unable to serialize token string from data")
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: nonce)
            //Firebase 로그인 메서드 호출.
            LoginManager.shared.signInFirebase(with: credential)
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("DEBUG: 애플 로그인 에러 - \(error.localizedDescription)")
    }
}



//MARK: - 사용 예시
//struct LoginTestView: View {
//    @State var signInWithGoogleObject = SignInWithGoogleObject()
//    @State var signInWithAppleObject = SignInWithAppleObject()
//
//
//    init() {
//        LoginManager.shared.logOut()
//    }
//
//    var body: some View {
//        VStack(spacing: 30) {
//            Button("Google ") {
//                signInWithGoogleObject.signWithGoogle()
//            }
//
//            Button("Apple ") {
//                signInWithAppleObject.signInWithApple()
//            }
//        }
//    }
//}
//

