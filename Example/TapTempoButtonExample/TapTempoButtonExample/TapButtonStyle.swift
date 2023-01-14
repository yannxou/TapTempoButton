//
//  TapButtonStyle.swift
//  TapTempoButtonExample
//
//  Created by Joan Duat on 14/1/23.
//

import SwiftUI

struct TapButtonStyle: ButtonStyle {
    private let backgroundColor: Color = .gray.opacity(0.25)
    private let highlightColor: Color = .green.opacity(0.75)

    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(.horizontal, 40)
            .padding(.vertical, 10)
            .background(configuration.isPressed ? highlightColor : backgroundColor)
            .clipShape(Capsule())
    }
}
