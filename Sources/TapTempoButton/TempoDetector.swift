//
//  TempoDetector.swift
//  TapTempoButton
//
//  Created by Joan Duat on 22/12/22.
//

import Foundation

public class TempoDetector: ObservableObject {
    /// The tempo average (in BPM) based on the frequency of the calls to the `handleBeat` function.
    @Published public private(set) var detectedTempo: Double?

    private let minTaps: Int
    private let maxTaps: Int = 8
    private let timeout: TimeInterval
    private let tempoRange: ClosedRange<Double>
    private let roundDecimals: Int?

    private var timeoutTimer: Timer?
    private var times: [TimeInterval] = []
    private var lastTapDate: Date? = nil
    private var lastDifference: TimeInterval = 0

    /// Initializes a new `TempoDetector` instance that can be used to find the average tempo (in beats per minute) based on the frequency of the calls to the `handleBeat` function.
    /// - Parameters:
    ///   - tempoRange: Defines the minimum and maximum tempo that can be detected. `detectedTempo` output will be clamped to this range.
    ///   - timeout: Seconds of inactivity after which the ongoing detection will be restarted.
    ///   - minTaps: Minimum number of taps required before updating the `detectedTempo` output.
    ///   - roundDecimals: Number of decimals to round the BPM to. Set to `0` for integer-only BPM (no decimals). Set to `nil` to disable rounding.
    public init(tempoRange: ClosedRange<Double> = 20...999,
                timeout: TimeInterval = 2,
                minTaps: Int = 3,
                roundDecimals: Int? = 1) {
        self.tempoRange = tempoRange
        self.timeout = timeout
        self.minTaps = minTaps
        self.roundDecimals = roundDecimals
    }

    deinit {
        timeoutTimer?.invalidate()
    }

    public func handleBeat() {
        let time = Date()
        if let lastTapDate {
            lastDifference = time.timeIntervalSince(lastTapDate)
            times.append(lastDifference)
            if times.count > maxTaps {
                times.removeFirst()
            }
            refresh()
        }
        lastTapDate = time
        startTimeout()
    }

    private func refresh() {
        guard times.count >= minTaps else { return }
        let average = times.reduce(0, +) / Double(times.count)
        let tempo = min(tempoRange.upperBound, max(tempoRange.lowerBound, 60 / average))
        if let roundDecimals {
            detectedTempo = tempo.rounded(toDecimalPlaces: roundDecimals)
        } else {
            detectedTempo = tempo
        }
    }

    private func startTimeout() {
        timeoutTimer?.invalidate()
        timeoutTimer = Timer.scheduledTimer(timeInterval: timeout, target: self, selector: #selector(onTimeout), userInfo: nil, repeats: false)
    }

    @objc private func onTimeout() {
        times = []
        lastTapDate = nil
    }
}
