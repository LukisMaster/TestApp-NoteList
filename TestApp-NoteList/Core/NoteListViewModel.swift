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
    
    // MARK: Vars
    @Published var notes : [NoteEntity] = []

    private let viewContext = CoreDataManager.shared.context
    
    // MARK: Funcs
    func getNotes() {
        let request = NSFetchRequest<NoteEntity>(entityName: "NoteEntity")
        do {
            notes = try viewContext.fetch(request).reversed()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func getFontOf(note: NoteEntity) -> Font {
        var font = Font.system(size: CGFloat(Int(note.fontSize)),
                               weight: Font.Weight.allCases[Int(note.fontWeight)],
                               design: Font.Design.allCases[Int(note.fontDesign)])
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
    
    func getImageBy(note: NoteEntity) -> Image? {
        if let imageData = note.image, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return nil
        }
    }
    
    // MARK: Private funcs
    private func saveToCoreData () {
        do {
            try viewContext.save()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
