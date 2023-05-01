//
//  login.swift
//  MyNotes
//
//  Created by Muhammet Kadir on 29.04.2023.
//

import SwiftUI
import FirebaseAuth
struct LoginView: View {
    @State  private var email = ""
    @State private var password = ""
    
    @StateObject var authViewModel = AuthViewModel()


    var body: some View {
        NavigationView{
            VStack{
                TextField("E-mail", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 10)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
                    .padding(.bottom, 30)
                HStack{
                    Button {
                        authViewModel.signIn(email: email, password: password)
                    } label: {
                        Text("Sign In")
                    }
                    Spacer()
                    Button {
                        authViewModel.signUp(email: email, password: password)
                    } label: {
                        Text("Sign Up")
                    }
                }.padding(.horizontal,15.w)
                
            }
        }
    }
}

struct login_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
