//
//  TestApp_NoteListApp.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 15.02.2023.
//

import SwiftUI

@main
struct TestApp_NoteListApp: App {
    
    init() {
        let defaults = UserDefaults.standard
        if defaults.string(forKey: "appFirstLaunch") == nil {
            firstLaunchData()
            defaults.set(true, forKey: "appFirstLaunch")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                NoteListView()
            }
        }
    }
    
    private func firstLaunchData () {
        let dataManager = CoreDataManager.shared
        let note = NoteEntity(context: dataManager.context)
        note.text = "First launch note"
        note.italic = true
        dataManager.save()
    }
}
