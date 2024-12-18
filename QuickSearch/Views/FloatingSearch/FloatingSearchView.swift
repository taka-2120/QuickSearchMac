//
//  FloatingSearchView.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import SwiftData
import SwiftUI

struct FloatingSearchView: View {
    @Environment(\.openURL) private var openURL
    @Environment(\.dismissWindow) private var dismissWindow

    @FocusState private var isSearchFocused: Bool
    @Query private var quickSearches: [QuickSearch]
    @State private var sharedSearchConfig = SharedSearchConfig.shared
    @State private var searchQuery = ""
    private var search: QuickSearch? {
        quickSearches.first(where: { sharedSearchConfig.id ?? "" == "\($0.id)" })
    }

    var body: some View {
        Group {
            if let search {
                VStack(alignment: .leading) {
                    Text("Search \(search.name)")
                        .font(.title2)
                        .bold()
                        .padding(.bottom)
                    Text(search.url)
                        .foregroundStyle(Color(.secondaryLabelColor))
                    TextField(search.url, text: $searchQuery)
                        .focusable()
                        .focused($isSearchFocused)
                        .textFieldStyle(.roundedBorder)
                        .onSubmit {
                            guard let url = URL(string: search.url + searchQuery) else { return }
                            openURL(url)
                            FloatingSearchController.shared?.closeWindow()
                        }
                }
                .frame(width: 300)
                .padding()
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .onAppear {
                    isSearchFocused = true
                }
            } else {
                Text("Invalid Shortcut")
            }
        }
    }
}

#Preview {
    FloatingSearchView()
}
