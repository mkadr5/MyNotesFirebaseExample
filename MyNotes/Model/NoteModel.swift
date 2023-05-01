//
//  NoteModel.swift
//  MyNotes
//
//  Created by Muhammet Kadir on 29.04.2023.
//

import SwiftUI

struct NoteModel: Identifiable {
    var id: String?
    var note: String
    var uuid: String
    var date: Date
}
