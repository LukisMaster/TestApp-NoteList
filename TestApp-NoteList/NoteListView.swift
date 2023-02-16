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
            
            List {
                ForEach(viewModel.notes) { entity in
                    Text(entity.text ?? "")
                        .font(viewModel.getFontOf(note: entity))
                }
                .onDelete (perform: viewModel.deleteNote)
            }
            .listStyle(.plain)
            .onAppear {
                viewModel.getNotes()
            }
            
            Spacer()
            
            addNoteButton

        }
        .navigationTitle("Note list")
    }
}

struct NoteListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            NoteListView()
        }
    }
}

extension NoteListView {
    private var addNoteButton: some View {
        NavigationLink {
            AddNoteView()
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
