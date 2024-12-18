//
//  SearchListView.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import KeyboardShortcuts
import SwiftData
import SwiftUI

struct SearchListView: View {
    @Environment(\.dismissWindow) private var dismissWindow
    @Environment(\.modelContext) private var modelContext
    @Environment(\.openWindow) private var openWindow

    @FocusState private var isReadingKeys: Bool
    @Query private var quickSearches: [QuickSearch]
    @State private var selectedItemIDs = Set<QuickSearch.ID>()
    @State private var isSaveErrorOccurred = false
    @State private var sharedSearchConfig = SharedSearchConfig.shared

    var body: some View {
        VStack(spacing: 0) {
            Table(quickSearches, selection: $selectedItemIDs) {
                TableColumn("Site Name") { quickSearch in
                    searchNameItem(for: quickSearch.id, name: quickSearch.name)
                }
                TableColumn("URL") { quickSearch in
                    searchURLItem(for: quickSearch.id, url: quickSearch.url)
                }
                TableColumn("Shortcut Key") { quickSearch in
                    KeyboardShortcuts.Recorder("", name: .init("\(quickSearch.id)"))
                }
                .width(150)
            }

            HStack(spacing: 0) {
                Button {
                    modelContext.insert(
                        QuickSearch(
                            name: "",
                            url: "",
                            shortcutKey: "",
                            shortcutModifier: 0
                        )
                    )
                } label: {
                    Image(systemName: "plus")
                        .padding(10)
                }
                .buttonStyle(.borderless)
                .keyboardShortcut("a", modifiers: [.command, .shift])

                Button {
                    for selectedItemId in selectedItemIDs {
                        guard let selectedItem = quickSearches.first(where: { $0.id == selectedItemId }) else { continue }
                        modelContext.delete(selectedItem)
                    }
                } label: {
                    Image(systemName: "minus")
                        .padding(10)
                }
                .buttonStyle(.borderless)
                .disabled(selectedItemIDs.isEmpty)

                Spacer()

                Button {
                    for search in quickSearches {
                        if search.name.isEmpty || search.url.isEmpty {
                            isSaveErrorOccurred = true
                            return
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
                    try? modelContext.save()
                } label: {
                    Text("Save")
                        .padding(10)
                        .foregroundStyle(Color.accentColor)
                }
                .buttonStyle(.borderless)
            }
        }
        .alert("Error", isPresented: $isSaveErrorOccurred) {
            Button("OK", role: .destructive, action: {})
        } message: {
            Text("Please fill all names and URLs.")
        }
    }

    @ViewBuilder
    func searchNameItem(for id: PersistentIdentifier, name: String) -> some View {
        let binding = Binding<String>(
            get: { name },
            set: {
                if let id = quickSearches.firstIndex(where: { $0.id == id }) {
                    self.quickSearches[id].name = $0
                }
            }
        )
        TextField("Name", text: binding)
    }

    @ViewBuilder
    func searchURLItem(for id: PersistentIdentifier, url: String) -> some View {
        let binding = Binding<String>(
            get: { url },
            set: {
                if let id = quickSearches.firstIndex(where: { $0.id == id }) {
                    self.quickSearches[id].url = $0
                }
            }
        )
        TextField("https://www.google.com/search?q=", text: binding)
    }
}

#Preview {
    SearchListView()
        .modelContainer(for: QuickSearch.self)
}
