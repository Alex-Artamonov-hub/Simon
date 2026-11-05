//
//  ContentView.swift
//  Simon
//
//  Created by Alex Artamonov on 11/4/26.
//



import SwiftUI

struct ContentView: View {

    @State private var score = 0
    @State private var highScore = 0

    @State private var sequence: [GameColor] = []
    @State private var playerSequence: [GameColor] = []

    @State private var activeColor: GameColor?

    @State private var isGameStarted = false
    @State private var isShowingSequence = false

    private let sounds = Sounds()

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()

            VStack(spacing: 30) {

                Text("SIMON")
                    .font(.system(size: 42, weight: .bold))
                    .foregroundColor(.white)

                HStack(spacing: 50) {

                    VStack {
                        Text("SCORE")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("\(score)")
                            .font(.title)
                            .foregroundColor(.white)
                    }

                    VStack {
                        Text("BEST")
                            .font(.caption)
                            .foregroundColor(.gray)

                        Text("\(highScore)")
                            .font(.title)
                            .foregroundColor(.white)
                    }
                }

                Text(isShowingSequence ? "Watch the pattern" :
                     isGameStarted ? "Your turn" : "Remember the pattern")
                    .font(.headline)
                    .foregroundColor(.white.opacity(0.8))

                VStack(spacing: 12) {

                    HStack(spacing: 12) {
                        gameButton(.blue)
                        gameButton(.red)
                    }

                    HStack(spacing: 12) {
                        gameButton(.yellow)
                        gameButton(.green)
                    }
                }
                .padding(.horizontal, 25)

                Button {
                    startGame()
                } label: {
                    Text(isGameStarted ? "RESTART" : "START GAME")
                        .font(.headline)
                        .foregroundColor(.black)
                        .frame(width: 190, height: 55)
                        .background(Color.white)
                        .clipShape(Capsule())
                }
                .padding(.top, 10)
            }
            .padding()
        }
        .onAppear {
            highScore = ScoreManager.getHighScore()
        }
    }

    private func gameButton(_ color: GameColor) -> some View {
        SimonButton(
            color: color,
            isActive: activeColor == color,
            disabled: !isGameStarted || isShowingSequence
        ) {
            playerTapped(color)
        }
    }

    private func startGame() {
        score = 0
        sequence = []
        playerSequence = []
        activeColor = nil
        isGameStarted = true

        sounds.playStart()

        addNextColor()
    }

    private func addNextColor() {
        sequence.append(GameLogic.randomColor())
        playerSequence = []

        Task {
            await showSequence()
        }
    }

    private func showSequence() async {
        isShowingSequence = true

        try? await Task.sleep(nanoseconds: 500_000_000)

        for color in sequence {
            activeColor = color
            sounds.playColor(color)

            try? await Task.sleep(nanoseconds: 700_000_000)

            activeColor = nil

            try? await Task.sleep(nanoseconds: 250_000_000)
        }

        isShowingSequence = false
    }

    private func playerTapped(_ color: GameColor) {
        guard isGameStarted && !isShowingSequence else {
            return
        }

        activeColor = color
        sounds.playColor(color)

        playerSequence.append(color)

        let index = playerSequence.count - 1

        if playerSequence[index] != sequence[index] {
            endGame()
            return
        }

        if playerSequence.count == sequence.count {
            score += 1

            if score > highScore {
                highScore = score
                ScoreManager.saveHighScore(score)
                sounds.playHighScore()
            }

            isShowingSequence = true

            Task {
                try? await Task.sleep(nanoseconds: 500_000_000)

                activeColor = nil

                try? await Task.sleep(nanoseconds: 400_000_000)

                addNextColor()
            }

        } else {
            Task {
                try? await Task.sleep(nanoseconds: 250_000_000)
                activeColor = nil
            }
        }
    }

    private func endGame() {
        isGameStarted = false
        isShowingSequence = false
        activeColor = nil

        sounds.playLose()
    }
}

#Preview {
    ContentView()
}
