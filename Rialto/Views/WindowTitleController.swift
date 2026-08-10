//
//  WindowTitleController.swift
//  Rialto
//
//  The app normally hides the window title text (set once, statically, via
//  .windowToolbarStyle(.unified(showsTitle: false)) in RialtoApp.swift) since
//  the custom header supplies branding instead. When the header is dismissed
//  there's no branding left in the window at all, so this bridges down to
//  the underlying NSWindow to reveal "Rialto" as plain title bar text —
//  something a static Scene-level modifier can't do, since it can't react
//  to view-level @State changes.
//

import SwiftUI
import AppKit

struct WindowTitleController: NSViewRepresentable {
    var isVisible: Bool
    var title: String = "Rialto"

    func makeNSView(context: Context) -> NSView {
        let view = NSView(frame: .zero)
        DispatchQueue.main.async { configure(view) }
        return view
    }

    func updateNSView(_ nsView: NSView, context: Context) {
        configure(nsView)
    }

    private func configure(_ view: NSView) {
        guard let window = view.window else { return }
        window.title = title
        window.titleVisibility = isVisible ? .visible : .hidden
    }
}
