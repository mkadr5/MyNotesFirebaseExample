//
//  NoteViewModel.swift
//  MyNotes
//
//  Created by Muhammet Kadir on 29.04.2023.
//

import SwiftUI
import Firebase

class NoteViewModel : ObservableObject {
    @Published var notes = [NoteModel]()
    private let db = Firestore.firestore()
    
    func getNotes(uid:String) {
        notes.removeAll()
        db.collection("Notes").whereField("uuid", isEqualTo: uid).getDocuments() { (querySnapshot, error) in
            if let error = error {
                print("Error getting notes: \(error.localizedDescription)")
                return
            }
            for document in querySnapshot!.documents {
                guard let note = document.data()["note"] as? String,
                      let uuid = document.data()["uuid"] as? String,
                      let date = document.data()["date"] as? Timestamp else {
                    continue
                }
                let id = document.documentID
                let noteModel = NoteModel(id: id, note: note, uuid: uuid, date: date.dateValue())
                self.notes.append(noteModel)
            }
        }
    }
    
    
    func addNote(note: NoteModel,completion: @escaping (Bool) -> Void){
        db.collection("Notes").addDocument(data: [
            "note": note.note,
            "uuid": note.uuid,
            "date": Timestamp(date: note.date)
        ]) { err in
            if let err = err {
                print("Error adding note: \(err.localizedDescription)")
                completion(false)
            } else {
                print("Note added successfully!")
                completion(true)
            }
        }
    }
    
    func editNote(note: NoteModel,completion: @escaping (Bool) -> Void){
        db.collection("Notes").document(note.id!).updateData(["note": note.note]) { error in
            if error != nil {
                print("Error : \(error?.localizedDescription ?? "")")
                completion(false)
            }else{
                completion(true)
            }
        }
    }
    
    func deleteNote(note: NoteModel, completion: @escaping (Bool) -> Void){
        db.collection("Notes").document(note.id ?? "").delete { error in
            if error != nil {
                print("Error deleted note: \(error?.localizedDescription ?? "")")
                completion(false)
            }else{
                print("Note deleted successfully!")
                completion(true)
            }
        }
    }
}
