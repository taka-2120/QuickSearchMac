//
//  InformationView.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import KeyboardShortcuts
import SwiftData
import SwiftUI

struct InformationView: View {
    @Environment(\.openURL) private var openURL

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List {
                    Section("Information") {
                        HStack {
                            Text("Version")
                            Spacer()
                            Text("1.0.0")
                                .foregroundStyle(Color(.secondaryLabelColor))
                        }
                    }
                    Section("Licenses") {
                        Button {
                            openURL(URL(string: "https://github.com/sindresorhus/KeyboardShortcuts/blob/main/license")!)
                        } label: {
                            HStack {
                                Text("Keyboard Shortcuts")
                                Spacer()
                                Image(systemName: "arrow.up.forward")
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                Text("Copyright © 2024 Yu Takahashi. All rights reserved.")
                    .foregroundStyle(Color(.secondaryLabelColor))
                    .padding(5)
            }
        }
    }
}

#Preview {
    InformationView()
}
