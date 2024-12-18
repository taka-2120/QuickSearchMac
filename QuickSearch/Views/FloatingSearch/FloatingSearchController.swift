//
//  FloatingSearchController.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/17/24.
//

import AppKit
import SwiftUI

class FloatingSearchController: NSWindowController {
    static var shared: FloatingSearchController?
    private var outsideClickMonitor: Any?

    init() {
        let screenFrame = NSScreen.main?.frame ?? NSRect(x: 0, y: 0, width: 800, height: 600)
        let windowRect = NSRect(x: screenFrame.midX - 200, y: screenFrame.midY - 200, width: 400, height: 300)

        let window = NSWindow(
            contentRect: windowRect,
            styleMask: [.titled],
            backing: .buffered,
            defer: false
        )

        window.isOpaque = false
        window.backgroundColor = .clear
        window.isMovableByWindowBackground = true
        window.level = .floating
        window.collectionBehavior = [.canJoinAllSpaces, .fullScreenAuxiliary]
        window.hasShadow = true
        window.ignoresMouseEvents = false

        window.standardWindowButton(.closeButton)?.isHidden = true
        window.standardWindowButton(.miniaturizeButton)?.isHidden = true
        window.standardWindowButton(.zoomButton)?.isHidden = true
        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true

        window.contentView = NSHostingView(rootView: FloatingSearchView().modelContainer(sharedModelContainer))

        super.init(window: window)
    }

    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func showWindow() {
        window?.makeKeyAndOrderFront(nil)
        window?.makeFirstResponder(self)
        NSApp.activate(ignoringOtherApps: true)
        addOutsideClickMonitor()
    }

    func closeWindow() {
        window?.close()
        if let monitor = outsideClickMonitor {
            NSEvent.removeMonitor(monitor)
            outsideClickMonitor = nil
        }

        FloatingSearchController.shared = nil
    }

    private func addOutsideClickMonitor() {
        outsideClickMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown]) { [weak self] _ in
            guard let self = self, let window = self.window else { return }

            let clickLocation = NSEvent.mouseLocation
            let windowFrame = window.frame

            if !windowFrame.contains(NSPoint(x: clickLocation.x, y: clickLocation.y)) {
                self.closeWindow()
            }
        }
    }
}
