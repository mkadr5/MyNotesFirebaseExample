//
//  DetailView.swift
//  MyNotes
//
//  Created by Muhammet Kadir on 30.04.2023.
//

import SwiftUI

struct DetailView: View {
    enum FocusField: Hashable {
        case field
    }
    
    @FocusState private var focusedField: FocusField?
    var note : NoteModel?
    @State var noteController = ""
    @StateObject var viewModel = NoteViewModel()
    @StateObject var authViewModel = AuthViewModel()
    
    
    
    @Environment(\.presentationMode) var presentationMode
    
    init(note: NoteModel? = nil) {
        if note != nil {
            self.note = note
            _noteController = State(initialValue: self.note?.note ?? "")
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .bottomTrailing) {
                TextEditor(text: $noteController)
                    .padding()
                    .focused($focusedField, equals: .field)
                    .onAppear {
                        self.focusedField = .field
                    }
                
                Button(action: {
                    
                    if var nNote = note {
                        nNote.note = noteController
                        viewModel.editNote(note: nNote) { result in
                            if result == true{
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }else{
                        viewModel.addNote(note: NoteModel(note: noteController, uuid: authViewModel.user?.uid ?? "", date: Date())) { res in
                            if res == true{
                                presentationMode.wrappedValue.dismiss()
                            }
                        }
                    }
                }) {
                    Text("Save")
                }
                .padding()
            }
            .navigationBarTitle(Text("Note"))
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
