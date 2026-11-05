//
//  GameColor.swift
//  Simon
//
//  Created by Alex Artamonov on 11/4/26.
//


import SwiftUI

enum GameColor: CaseIterable {
    case blue
    case red
    case yellow
    case green

    var color: Color {
        switch self {
        case .blue:
            return Color.blue
        case .red:
            return Color.red
        case .yellow:
            return Color.yellow
        case .green:
            return Color.green
        }
    }

    var soundName: String {
        switch self {
        case .blue:
            return "0"
        case .red:
            return "1"
        case .yellow:
            return "2"
        case .green:
            return "3"
        }
    }
}
