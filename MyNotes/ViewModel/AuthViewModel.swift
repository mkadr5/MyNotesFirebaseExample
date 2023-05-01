//
//  AuthViewModel.swift
//  MyNotes
//
//  Created by Muhammet Kadir on 29.04.2023.
//

import SwiftUI
import FirebaseAuth

class AuthViewModel : ObservableObject {
    @Published  var user : User?
    init() {
        listen()
    }
    
    func listen() {
        Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.user = user
            } else {
                self.user = nil
            }
        })
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { auth, error in
            if error != nil{
                print(error?.localizedDescription ?? "")
            }else{
                self.user = auth?.user
            }
        }
    }
    
    func signUp(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { auth, error in
            if error != nil{
                print(error?.localizedDescription ?? "")
            }else{
                self.user = auth?.user
            }
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.user = nil
        } catch let error {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

