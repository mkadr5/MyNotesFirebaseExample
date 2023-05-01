//
//  ContentView.swift
//  MyNotes
//
//  Created by Muhammet Kadir on 29.04.2023.
//

import SwiftUI
import FirebaseAuth
struct ContentView: View {
    @ObservedObject var auth = AuthViewModel()
    var body: some View {
        VStack{
            if auth.user == nil{
                LoginView()
            }else{
                NotesView()
            }
           
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
