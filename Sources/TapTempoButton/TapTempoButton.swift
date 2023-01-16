//
//  TapTempoButton.swift
//  TapTempoButton
//
//  Created by Joan Duat on 10/1/23.
//

import SwiftUI

#if os(iOS)
import UIKit
#endif

public struct TapTempoButton<Content: View>: View {
    @StateObject private var tempoDetector: TempoDetector
    private let content: Content
    private let onTempoChange: (Double) -> Void

    /// Creates a TapTempoButton that calculates the BPM average based on the taps received.
    /// - Parameters:
    ///   - tempoRange: Defines the minimum and maximum tempo that can be detected.
    ///   - timeout: Seconds of inactivity after which the ongoing detection will be restarted.
    ///   - minTaps: Minimum number of taps required before sending values to the `onTempoChange` closure.
    ///   - roundDecimals: Number of decimals to round the BPM to. Set to `0` for integer-only BPM (no decimals). Set to `nil` to disable rounding.
    ///   - onTempoChange: The closure called providing the average BPM.
    ///   - content: The content that will act as the tap button.
    public init(tempoRange: ClosedRange<Double> = 20...999,
                timeout: TimeInterval = 2,
                minTaps: Int = 3,
                roundDecimals: Int? = 1,
                onTempoChange: @escaping (Double) -> Void,
                @ViewBuilder content: @escaping () -> Content
    ) {
        _tempoDetector = StateObject(wrappedValue: TempoDetector(
            tempoRange: tempoRange,
            timeout: timeout,
            minTaps: minTaps,
            roundDecimals: roundDecimals
        ))

        self.onTempoChange = onTempoChange
        self.content = content()
    }

    public var body: some View {
        contentButton
            .onReceive(tempoDetector.$detectedTempo) { tempo in
                if let tempo {
                    onTempoChange(tempo)
                }
            }
    }

    @ViewBuilder private var contentButton: some View {
#if os(tvOS)
        // touchUpButton
        Button(action: tempoDetector.handleBeat) {
            content
        }
#else
        // touchDownButton
        Button(action: { }) {
            content
        }
        .onTouchDownGesture(tempoDetector.handleBeat)
#endif
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
