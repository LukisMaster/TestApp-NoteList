//
//  AddNoteView.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 15.02.2023.
//

import SwiftUI

struct AddNoteView: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var viewModel = AddNoteViewModel()
    @State private var opacity : Double = 1
    
    var body: some View {
        VStack {
            TextField("Note text...", text: $viewModel.noteText)
                .font(viewModel.textFont)
                .padding(.leading)
                .frame(height: 55)
                .background(Color(white: 0.93))
                .cornerRadius(10)
            HStack {
                Toggle("Bold", isOn: $viewModel.noteBold)
                    .font(.body.bold())
                    .frame(width: 120, alignment: .leading)
                Spacer()
                Toggle("Italic", isOn: $viewModel.noteItalic)
                    .font(.body.italic())
                    .frame(width: 120, alignment: .trailing)

            }
            Spacer()
            saveNoteButton
                .alert(isPresented: $viewModel.showAlert) {
                    showAlert()
                }
        }
        .padding()
        .navigationTitle(viewModel.navigationTitleText)
        
    }
}

struct AddNoteView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddNoteView()
        }
    }
}


extension AddNoteView {
    
    private var saveNoteButton: some View {
        Button {
            viewModel.saveNote()
            
            
        } label: {
            Text("Add note")
                .font(.headline)
                .accentColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
                .cornerRadius(10)
                .opacity(opacity)
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
