//
//  View+Extenshions.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 18.02.2023.
//

import SwiftUI

extension View {
    func listRowEditNoteStyle() -> some View {
        self
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            .listRowBackground(Color.clear)
    }
}
