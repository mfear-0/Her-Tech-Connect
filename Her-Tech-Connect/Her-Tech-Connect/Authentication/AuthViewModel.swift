//
//  AuthViewModel.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/23/21.
//

import Foundation
import FirebaseAuth

class AuthViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var signedIn = false
    @Published var userAlreadyExist = false
    @Published var isWrongEmail = false
    @Published var isWrongPassword = false
    @Published var isFilled = true
    var isSignedIn: Bool{
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String){
        auth.signIn(withEmail: email, password: password) {[weak self] result, error in
            
            //Check for user credential
            if let x = error {
                  let err = x as NSError
                  switch err.code {
                  case AuthErrorCode.wrongPassword.rawValue:
                    self?.isWrongEmail = false
                    self?.isWrongPassword = true
                    self?.isFilled = true
                    
                  case AuthErrorCode.invalidEmail.rawValue:
                    self?.isWrongEmail = true
                    self?.isWrongPassword = false
                    self?.isFilled = true
                    
                  default:
                     print("unknown error: \(err.localizedDescription)")
                  }
                  //return
               }
            
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
                self?.isWrongEmail = false
                self?.isWrongPassword = false
                self?.isFilled = true
            }
        }
    }
    
    func signUp(email: String, password: String){
        auth.createUser(withEmail: email, password: password) {[weak self] result, error in
            
            //Check if user already exists
            if let x = error {
                  let err = x as NSError
                  switch err.code {
                      case AuthErrorCode.emailAlreadyInUse.rawValue:
                        self?.userAlreadyExist = true
                      default:
                         print("unknown error: \(err.localizedDescription)")
                      }
                  //return
               }
            
            guard result != nil, error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                //Success
                self?.signedIn = true
                self?.userAlreadyExist = false
            }
            
        }
    }
    
    func signOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}
