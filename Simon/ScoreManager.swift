//
//  ScoreManager.swift
//  Simon
//
//  Created by Alex Artamonov on 11/4/26.
//


import Foundation

struct ScoreManager {

    private static let highScoreKey = "SimonHighScore"

    static func getHighScore() -> Int {
        return UserDefaults.standard.integer(
            forKey: highScoreKey
        )
    }

    static func saveHighScore(_ score: Int) {
        UserDefaults.standard.set(
            score,
            forKey: highScoreKey
        )
    }
}
