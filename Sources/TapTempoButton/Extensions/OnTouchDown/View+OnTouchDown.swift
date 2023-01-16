//
//  View+OnTouchDown.swift
//  TapTempoButton
//
//  Created by Joan Duat on 22/12/22.
//

#if !os(tvOS)

import SwiftUI

extension View {
    func onTouchDownGesture(_ callback: @escaping () -> Void) -> some View {
        modifier(OnTouchDownGestureModifier(callback: callback))
    }
}

private struct OnTouchDownGestureModifier: ViewModifier {
    @State private var tapped = false
    let callback: () -> Void

    func body(content: Content) -> some View {
#if os(macOS)
        content
            .overlay {
                EventSpy(onMouseDown: { _ in
                    self.callback()
                })
            }
#else
        content
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if !self.tapped {
                        self.tapped = true
                        self.callback()
                    }
                }
                .onEnded { _ in
                    self.tapped = false
                })
#endif
    }
}

#endif
