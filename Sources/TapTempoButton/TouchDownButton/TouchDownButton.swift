//
//  TouchDownButton.swift
//  TapTempoButton
//
//  Created by Joan Duat on 16/1/23.
//

#if !os(tvOS)

import SwiftUI

struct TouchDownButton<Content: View>: View {
    private let action: () -> Void
    private let content: Content
    @State private var tapped = false

    init(action: @escaping () -> Void,
         @ViewBuilder content: @escaping () -> Content) {
        self.action = action
        self.content = content()
    }

    var body: some View {
#if os(macOS)
        button
            .overlay {
                EventSpy(onMouseDown: { _ in
                    tapped = true
                    action()
                }, onMouseUp: { _ in
                    tapped = false
                })
            }
#else
        button
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !tapped {
                        tapped = true
                        action()
                    }
                }
                .onEnded { _ in
                    DispatchQueue.main.async {
                        tapped = false
                    }
                })
#endif
    }

    private var button: some View {
        Button(action: {
            if !tapped {
                action()
            }
        }) {
            content
        }
    }
}

#endif
