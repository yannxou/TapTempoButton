//
//  TapTempoButton.swift
//  TapTempoButton
//
//  Created by Joan Duat on 10/1/23.
//

import SwiftUI

public struct TapTempoButton<Content: View>: View {
    @StateObject private var tempoDetector = TempoDetector()
    private let content: Content
    private let onTempoChange: (Double) -> Void

    public init(onTempoChange: @escaping (Double) -> Void,
                @ViewBuilder content: @escaping () -> Content) {
        self.onTempoChange = onTempoChange
        self.content = content()
    }

    public var body: some View {
        content
            .onTouchDownGesture(tempoDetector.handleBeat)
            .onReceive(tempoDetector.$detectedTempo) { tempo in
                if let tempo {
                    onTempoChange(tempo)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {

    static var previews: some View {
        Content()
    }

    struct Content: View {
        @State var tempo: Double = 120

        var body: some View {
            TapTempoButton(onTempoChange: { tempo = $0 }) {
                Text(String(tempo))
                    .font(.largeTitle.bold())
                    .frame(minWidth: 200, minHeight: 100)
                    .border(.foreground, width: 2)
                    .contentShape(Rectangle())
            }
        }
    }
}
