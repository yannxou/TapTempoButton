//
//  ContentView.swift
//  TapTempoButtonExample
//
//  Created by Joan Duat on 10/1/23.
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
                    .padding(.horizontal, 40)
                    .padding(.vertical, 10)
            }
            .buttonBorderShape(.capsule)
            .buttonStyle(.bordered)
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
