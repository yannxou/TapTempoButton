//
//  ContentView.swift
//  TapTempoButtonWatchExample Watch App
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
                Button(action: { }) {
                    Text("Tap")
                        .padding(.horizontal, 40)
                        .padding(.vertical, 10)
                }
                .buttonBorderShape(.capsule)
                .buttonStyle(.bordered)
            }
        }
        .padding()
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
