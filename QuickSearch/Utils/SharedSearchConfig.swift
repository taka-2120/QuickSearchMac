//
//  SharedSearchConfig.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/16/24.
//

import SwiftUICore

@Observable
class SharedSearchConfig {
    static let shared = SharedSearchConfig()
    private init() {}

    var id: String?
}
