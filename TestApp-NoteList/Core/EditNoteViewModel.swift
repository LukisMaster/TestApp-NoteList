//
//  EditNoteViewModel.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 15.02.2023.
//

import CoreData
import SwiftUI

final class EditNoteViewModel : ObservableObject {
    // MARK: Vars
    private let viewContext = CoreDataManager.shared.context
    @Published var showAlert = false
    @Published var noteText : String
    @Published var noteItalic : Bool {
        didSet {
            changeTextFont()
        }
    }
    
    @Published var fontWeightIndex : Int{
        didSet {
            changeTextFont()
        }
    }
    @Published var fontDesignIndex : Int {
        didSet {
            changeTextFont()
        }
    }
    
    @Published var fontSize : Double {
        didSet {
            changeTextFont()
        }
    }
    
    @Published var pickerImage : UIImage? 
        
    var textFont : Font = .system(size: 17, weight: .regular, design: .default)
    @Published var navigationTitleText : String
    
    var pickerVisible : Bool
    let isEditView : Bool
    let note: NoteEntity!
    
    // MARK: Initialization
    init (entity: NoteEntity? = nil) {
        if let entity = entity {
            noteText = entity.text ?? ""
            noteItalic = entity.italic
            fontWeightIndex = Int(entity.fontWeight)
            fontDesignIndex = Int(entity.fontDesign)
            fontSize = Double(entity.fontSize)
            if let imageData = entity.image {
                pickerImage = UIImage(data: imageData)
                pickerVisible = false
            } else {
                pickerVisible = true
            }
            isEditView = true
            navigationTitleText = "Edit Note"
            note = entity
        } else {
            isEditView = false
            navigationTitleText = "New Note"
            note = nil
            noteText = ""
            noteItalic = false
            fontWeightIndex = 0
            fontDesignIndex = 0
            fontSize = 17
            pickerVisible = true
        }
    }
    
    // MARK: Funcs
    func saveNote() {
        guard !noteText.isEmpty else {
            showAlert = true
            return
        }
        
        let noteEntity = note ?? NoteEntity(context: viewContext)
        noteEntity.text = noteText
        noteEntity.italic = noteItalic
        noteEntity.fontSize = Int16(fontSize)
        noteEntity.fontWeight = Int16(fontWeightIndex)
        noteEntity.fontDesign = Int16(fontDesignIndex)
        noteEntity.image = pickerImage?.jpegData(compressionQuality: 1)

        saveToCoreData()
        if !isEditView {
            clearInputFields()
        } else {
            if let _ = noteEntity.image {
                pickerVisible = false
            } else {
                pickerVisible = true
            }
        }
        
        navigationTitleText = "Success!"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) { [weak self] in
            self?.navigationTitleText = self!.isEditView ? "Edit Note" : "New Note"
        }
    }
    
    func clearImage() {
        pickerVisible = true
        pickerImage = nil
    }
        
    // MARK: Private funcs
    private func clearInputFields() {
        showAlert = false
        noteText = ""
        noteItalic = false
        fontWeightIndex = 0
        fontDesignIndex = 0
        fontSize = 17
        pickerImage = nil
    }
    
    private func changeTextFont() {
        var font = Font.system(size: fontSize,
                               weight: Font.Weight.allCases[fontWeightIndex],
                               design: Font.Design.allCases[fontDesignIndex])
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
