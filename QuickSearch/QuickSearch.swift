//
//  QuickSearch.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import Foundation
import SwiftData

@Model
public class QuickSearch: Identifiable {
    public var name: String = ""
    public var url: String = ""
    public var shortcutKey: String = ""
    public var shortcutModifier: Int = 0

    public init(name: String, url: String, shortcutKey: String, shortcutModifier: Int) {
        self.name = name
        self.url = url
        self.shortcutKey = shortcutKey
        self.shortcutModifier = shortcutModifier
    }
}
