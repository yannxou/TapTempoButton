//
//  EventSpy.swift
//  TapTempoButton
//
//  Created by Joan Duat on 16/1/23.
//

#if os(macOS)

import SwiftUI

class EventSpyView: NSView {
    var onMouseDown: ((NSEvent) -> Void)?
    var onMouseUp: ((NSEvent) -> Void)?

    init() {
        super.init(frame: .zero)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func mouseDown(with event: NSEvent) {
        onMouseDown?(event)
        super.mouseDown(with: event)
    }

    override func mouseUp(with event: NSEvent) {
        onMouseUp?(event)
        super.mouseUp(with: event)
    }
}

struct EventSpy: NSViewRepresentable {
    var onMouseDown: ((NSEvent) -> Void)?
    var onMouseUp: ((NSEvent) -> Void)?

    func makeNSView(context: Context) -> EventSpyView {
        let view = EventSpyView()
        return view
    }

    func updateNSView(_ nsView: EventSpyView, context: Context) {
        nsView.onMouseDown = onMouseDown
        nsView.onMouseUp = onMouseUp
    }
}

#endif
