//
//  Font+Extensions.swift
//  TestApp-NoteList
//
//  Created by Sergey Nestroyniy on 17.02.2023.
//

import SwiftUI

extension Font.Design: CaseIterable {
    public static var allCases: [Font.Design] {
        [.default, .monospaced, .serif, .rounded]
    }
    
    public static var allNames : [String] {
        ["Default", "Monospaced", "Serif", "Rounded"]
    }
}

extension Font.Weight: CaseIterable {
    public static var allCases: [Font.Weight] {
        [Font.Weight.regular,
         Font.Weight.bold,
         Font.Weight.semibold,
         Font.Weight.heavy,
         Font.Weight.light,
         Font.Weight.medium,
         Font.Weight.thin,
         Font.Weight.ultraLight,
         Font.Weight.black]
    }
    
    public static var allNames : [String] {
        ["Regular",
         "Bold",
         "Semibold",
         "Heavy",
         "Light",
         "Medium",
         "Thin",
         "UltraLight",
         "Black"]
    }
}
