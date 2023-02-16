//
//  AddNoteViewModel.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 15.02.2023.
//

import CoreData
import SwiftUI

final class AddNoteViewModel : ObservableObject {
    private let viewContext = CoreDataManager.shared.context
    @Published var showAlert = false
    @Published var noteText = ""
    @Published var noteBold = false {
        didSet {
            changeTextFont()
        }
    }
    @Published var noteItalic = false {
        didSet {
            changeTextFont()
        }
    }
    
    var textFont : Font = .body
    @Published var navigationTitleText = "New Note"
    
    func saveNote() {
        guard !noteText.isEmpty else {
            showAlert = true
            return
        }
        let newNote = NoteEntity(context: viewContext)
        newNote.text = noteText
        newNote.bold = noteBold
        newNote.italic = noteItalic
        saveToCoreData()
        clearInputFields()
        
        navigationTitleText = "Success!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.navigationTitleText = "New Note"
        }
    }
        
    private func clearInputFields() {
        showAlert = false
        noteText = ""
        noteBold = false
        noteItalic = false
    }
    
    private func changeTextFont() {
        var font = Font.body
        if noteBold { font = font.bold() }
        if noteItalic { font = font.italic() }
        textFont = font
    }
    
    private func saveToCoreData () {
        do {
            try viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }

}
