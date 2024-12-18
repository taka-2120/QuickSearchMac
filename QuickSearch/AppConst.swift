//
//  AppConst.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/17/24.
//

import SwiftData

let sharedModelContainer: ModelContainer = {
    let schema = Schema([
        QuickSearch.self,
    ])
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

    do {
        return try ModelContainer(for: schema, configurations: [modelConfiguration])
    } catch {
        fatalError("Could not create ModelContainer: \(error)")
    }
}()
