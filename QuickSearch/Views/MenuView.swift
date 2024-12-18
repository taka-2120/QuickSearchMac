//
//  MenuView.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import SwiftData
import SwiftUI

struct MenuView: View {
    @State private var sharedSearchConfig = SharedSearchConfig.shared
    @Query private var quickSearches: [QuickSearch]

    var body: some View {
        Group {
            if quickSearches.isEmpty {
                Button("Add", systemImage: "plus.circle.fill") {}
            } else {
                ForEach(quickSearches) { search in
                    Button {
                        sharedSearchConfig.id = "\(search.id)"

                        if let existingController = FloatingSearchController.shared {
                            existingController.closeWindow()
                        }
                        FloatingSearchController.shared = .init()
                        FloatingSearchController.shared?.showWindow()
                    } label: {
                        Text(search.name)
                    }
                }
            }

            Divider()

            SettingsLink { Text("Settings") }

            Divider()

            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q")
        }
    }
}

#Preview {
    MenuView()
}
