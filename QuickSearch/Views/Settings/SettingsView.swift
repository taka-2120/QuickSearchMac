//
//  SettingsView.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import SwiftUI

struct SettingsView: View {
    var body: some View {
        TabView {
            Tab {
                SearchListView()
            } label: {
                Label("Search", systemImage: "magnifyingglass")
            }
            Tab {
                InformationView()
            } label: {
                Label("Information", systemImage: "info.circle")
            }
        }
        .frame(width: 500, height: 300)
    }
}

#Preview {
    SettingsView()
}
