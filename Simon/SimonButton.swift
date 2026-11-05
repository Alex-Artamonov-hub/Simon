//
//  SimonButton.swift
//  Simon
//
//  Created by Alex Artamonov on 11/4/26.
//


import SwiftUI

struct SimonButton: View {

    let color: GameColor
    let isActive: Bool
    let disabled: Bool
    let action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            RoundedRectangle(cornerRadius: 22)
                .fill(color.color)
                .frame(height: 145)
                .overlay {
                    RoundedRectangle(cornerRadius: 22)
                        .stroke(Color.white.opacity(0.25), lineWidth: 2)
                }
                .brightness(isActive ? 0.35 : 0)
                .shadow(
                    color: color.color.opacity(isActive ? 0.9 : 0.2),
                    radius: isActive ? 20 : 5
                )
                .scaleEffect(isActive ? 0.96 : 1.0)
                .animation(.easeInOut(duration: 0.15), value: isActive)
        }
        .buttonStyle(.plain)
        .disabled(disabled)
    }
}
