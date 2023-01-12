//
//  ContentView.swift
//  TapTempoMacExample
//
//  Created by Joan Duat on 12/1/23.
//

import SwiftUI
import TapTempoButton

struct ContentView: View {
    @State private var tempo: Double = 120
    @State private var buttonBackground: Color = .gray.opacity(0.25)

    var body: some View {
        VStack {
            Text("BPM").font(.caption)

            Text(String(tempo))
                .font(.largeTitle.bold())

            TapTempoButton(onTempoChange: onTempoChange) {
                Text("Tap")
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
                    .contentShape(Rectangle())
                    .background(buttonBackground)
            }
        }
    }

    private func onTempoChange(_ tempo: Double) {
        self.tempo = tempo
        flashButton()
    }

    private func flashButton() {
        buttonBackground = .green.opacity(0.25)
        withAnimation(.easeIn(duration: 0.15)) {
            buttonBackground = .gray.opacity(0.25)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
