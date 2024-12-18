//
//  QuickSearchApp.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import KeyboardShortcuts
import SwiftData
import SwiftUI

@main
struct QuickSearchApp: App {
    @State private var sharedSearchConfig = SharedSearchConfig.shared

    init() {
        setShortcuts()
    }

    private func setShortcuts() {
        let descriptor = FetchDescriptor<QuickSearch>()
        let quickSearches = try? ModelContext(sharedModelContainer).fetch(descriptor)
        guard let quickSearches else { return }

        for search in quickSearches {
            if search.name.isEmpty || search.url.isEmpty {
                continue
            }
            KeyboardShortcuts.onKeyUp(for: .init("\(search.id)")) {
                sharedSearchConfig.id = "\(search.id)"

                if let existingController = FloatingSearchController.shared {
                    existingController.closeWindow()
                }
                FloatingSearchController.shared = .init()
                FloatingSearchController.shared?.showWindow()
            }
        }
    }

    var body: some Scene {
        MenuBarExtra("", systemImage: "hare.fill") {
            MenuView()
                .modelContainer(sharedModelContainer)
        }

        Settings {
            SettingsView()
                .modelContainer(sharedModelContainer)
        }
        .persistentSystemOverlays(.visible)
        .defaultPosition(.center)
        .windowResizability(.contentSize)
        .windowLevel(.normal)
    }
}
