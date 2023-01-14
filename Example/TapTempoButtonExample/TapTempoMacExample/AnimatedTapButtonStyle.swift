//
//  AnimatedTapButtonStyle.swift
//  TapTempoMacExample
//
//  Created by Joan Duat on 13/1/23.
//

import SwiftUI
import Combine

struct AnimatedTapButtonStyle: ButtonStyle {
    let tempo: Double
    @State private var buttonBackground: Color = .gray.opacity(0.25)
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private let backgroundColor: Color = .gray.opacity(0.25)
    private let highlightColor: Color = .green.opacity(0.75)

    init(tempo: Double) {
        self.tempo = tempo
        timer = Timer.publish(every: 60 / tempo, on: .main, in: .common).autoconnect()
    }

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .contentShape(Rectangle())
            .background(configuration.isPressed ? highlightColor : buttonBackground)
            .onReceive(timer) { _ in
                flashButton()
            }
    }

    private func flashButton() {
        buttonBackground = highlightColor
        withAnimation(.easeIn(duration: 0.15)) {
            buttonBackground = backgroundColor
        }
    }
}
