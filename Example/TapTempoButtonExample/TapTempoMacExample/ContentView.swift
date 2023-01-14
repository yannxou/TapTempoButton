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

    var body: some View {
        VStack {
            Text("BPM").font(.caption)

            Text(String(tempo))
                .font(.largeTitle.bold())

            TapTempoButton(onTempoChange: onTempoChange) {
                Text("Tap")
            }
            .buttonStyle(AnimatedTapButtonStyle(tempo: tempo))
        }
    }

    private func onTempoChange(_ tempo: Double) {
        self.tempo = tempo
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
