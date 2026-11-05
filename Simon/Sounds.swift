//
//  Sounds.swift
//  Simon
//
//  Created by Alex Artamonov on 11/4/26.
//



import AVFoundation

class Sounds {

    private var player: AVAudioPlayer?

    func play(_ name: String) {
        guard let url = Bundle.main.url(
            forResource: name,
            withExtension: "wav"
        ) else {
            print("Missing sound: \(name).wav")
            return
        }

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.prepareToPlay()
            player?.play()
        } catch {
            print(error.localizedDescription)
        }
    }

    func playColor(_ color: GameColor) {
        play(color.soundName)
    }

    func playStart() {
        play("Start")
    }

    func playLose() {
        play("Lose")
    }

    func playHighScore() {
        play("HighScore")
    }
}
