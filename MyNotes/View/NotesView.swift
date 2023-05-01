//
//  NotesView.swift
//  MyNotes
//
//  Created by Muhammet Kadir on 29.04.2023.
//

import SwiftUI
import FirebaseAuth
struct NotesView: View {
    @StateObject var authViewModel = AuthViewModel()
    @StateObject var viewModel = NoteViewModel()
    @State private var showDetailView = false
    @State private var selectedNote : NoteModel?
    
    var body: some View {
        NavigationView{
            ZStack{
                VStack{
                    List{
                        ForEach(viewModel.notes.indices, id: \.self) { index in
                            VStack(alignment: .leading) {
                                Text(viewModel.notes[index].note.prefix(25))
                                    .font(.headline)
                                    .swipeActions(edge: .trailing,allowsFullSwipe: true, content: {
                                        Button(action: {
                                            viewModel.deleteNote(note: viewModel.notes[index]) { result in
                                                if result == true {
                                                    withAnimation {
                                                        viewModel.notes.remove(at: index)
                                                    }
                                                }
                                            }
                                        }, label: {
                                            Label("Delete", systemImage: "trash")
                                        })
                                    }).onTapGesture {
                                        self.selectedNote = viewModel.notes[index]
                                        showDetailView = true
                                    }
                            }
                        }
                    }.onAppear {
                        print("onappear: \(authViewModel.user?.uid ?? "bos")")
                        viewModel.getNotes(uid: authViewModel.user?.uid ?? "")
                    }
                }
                NavigationLink(
                    destination: DetailView(note: self.selectedNote),
                    isActive: $showDetailView,
                    label: {
                        EmptyView()
                    })
                Button(action: {
                    showDetailView = true
                }) {
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .padding(16)
                }
                .background(Color.blue)
                .clipShape(Circle())
                .padding()
                .position(x: (95.w-24),y: (80.h-24))
            }.navigationBarItems(trailing: Button(action: {
                authViewModel.signOut()
            }, label: {
                Image(systemName: "rectangle.portrait.and.arrow.forward")
            }))
            .navigationTitle(Text("My Notes"))
        }
    }
    
}

struct NotesView_Previews: PreviewProvider {
    static var previews: some View {
        NotesView()
    }
}
