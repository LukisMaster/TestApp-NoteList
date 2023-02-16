//
//  NoteListViewModel.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 16.02.2023.
//

import Foundation
import CoreData
import SwiftUI

final class NoteListViewModel : ObservableObject {
    private let viewContext = CoreDataManager.shared.context
    
    @Published var notes : [NoteEntity] = []
        
    func getNotes() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        do {
            notes = try viewContext.fetch(request).reversed()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getFontOf(note: NoteEntity) -> Font {
        var font = Font.body
        if note.bold { font = font.bold() }
        if note.italic { font = font.italic() }
        return font
    }
    
    func deleteNote(indexSet: IndexSet) {
        guard let index = indexSet.first else { return }
        let entity = notes[index]
        viewContext.delete(entity)
        saveToCoreData()
        getNotes()
    }
    
    private func saveToCoreData () {
        do {
            try viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
