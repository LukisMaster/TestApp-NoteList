//
//  NoteListView.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 15.02.2023.
//

import SwiftUI

struct NoteListView: View {
    @StateObject private var viewModel = NoteListViewModel()
    
    var body: some View {
        VStack {
            
            // MARK: List of notes
            List {
                ForEach(viewModel.notes) { entity in
                    NavigationLink {
                        EditNoteView(noteEntity: entity)
                    } label: {
                        HStack {
                            viewModel.getImageBy(note: entity)?
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 36, maxHeight: 36)
                            Text(entity.text ?? "")
                                .font(viewModel.getFontOf(note: entity))
                                .lineLimit(1)
                        }
                    }
                }
                .onDelete (perform: viewModel.deleteNote)
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.getNotes()
            }
            
            Spacer()
            
            // MARK: Action Button
            addNoteButton

        }
        .navigationTitle("Note list")
    }
}

// MARK: PreviewProvider
struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoteListView()
        }
    }
}

// MARK: - Private vars
extension NoteListView {
    private var addNoteButton: some View {
        NavigationLink {
            EditNoteView()
        } label: {
            Text("Add note")
                .font(.headline)
                .accentColor(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .background(Color.blue)
                .cornerRadius(10)
                .padding()
        }
    }
}
