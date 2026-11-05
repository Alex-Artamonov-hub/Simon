//
//  GameLogic.swift
//  Simon
//
//  Created by Alex Artamonov on 11/4/26.
//


import Foundation

struct GameLogic {

    static func randomColor() -> GameColor {
        return GameColor.allCases.randomElement() ?? .blue
    }

}
