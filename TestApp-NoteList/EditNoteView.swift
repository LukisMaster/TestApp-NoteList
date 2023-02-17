//
//  EditNoteView.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 15.02.2023.
//

import SwiftUI

struct EditNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel : EditNoteViewModel
    
    init (noteEntity: NoteEntity? = nil) {
        if let noteEntity = noteEntity {
            viewModel = EditNoteViewModel(entity: noteEntity)
        } else {
            viewModel = EditNoteViewModel()
        }
    }
    
    var body: some View {
        VStack {
            
            // MARK: TextField
            TextField("Note text...", text: $viewModel.noteText)
                .font(viewModel.textFont)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(white: 0.93))
                .cornerRadius(10)
                .padding()

            // MARK: Font Settings
            List {
                
                AppNotePickerView(selectionIndex: $viewModel.fontDesignIndex, allIndexces: Font.Design.allCases.indices, pickerName: "Design", itemNames: Font.Design.allNames)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.clear)
                
                AppNotePickerView(selectionIndex: $viewModel.fontWeightIndex, allIndexces: Font.Weight.allCases.indices, pickerName: "Weight", itemNames: Font.Weight.allNames)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    .listRowBackground(Color.white)

                Toggle("Italic", isOn: $viewModel.noteItalic)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                fontSizeSlider
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                
            }
            .listStyle(.insetGrouped)
    
            // MARK: Action Button
            saveNoteButton
                .alert(isPresented: $viewModel.showAlert) {
                    showAlert()
                }
                .padding()

        }
        .navigationTitle(viewModel.navigationTitleText)
        
    }
}

// MARK: - PreviewProvider

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            EditNoteView()
        }
    }
}

// MARK: - Private vars and funcs

extension EditNoteView {
    
    private var saveNoteButton: some View {
        Button {
            viewModel.saveNote()
        } label: {
            Text("Save Note")
                .font(.headline)
                .accentColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
                .cornerRadius(10)
        }
    }
    
    private var fontSizeSlider: some View {
        HStack {
            Text("Size")
                .padding(.trailing)
            Slider(value: $viewModel.fontSize, in: 10...25, step: 1) {
                Text("Size")
            } minimumValueLabel: {
                Text("10")
            } maximumValueLabel: {
                Text("25")
            }
        }
    }
    
    private func showAlert() -> Alert {
        return Alert(
            title: Text("Please enter any text"),
            primaryButton: .default(Text("Ok")),
            secondaryButton: .destructive(
                Text("Back to home screen"),
                action: {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        )
    }
    
    
}

// MARK: - Reusable Structs
struct AppNotePickerView: View {
    @Binding var selectionIndex: Int
    var allIndexces : Range<Int>
    var pickerName : String
    var itemNames : [String]
    
    var body: some View {
        Picker(pickerName, selection: $selectionIndex) {
            ForEach(allIndexces, id:\.self) { index in
                Text(itemNames[index])
            }
        }
        .pickerStyle(.automatic)
    }
}
