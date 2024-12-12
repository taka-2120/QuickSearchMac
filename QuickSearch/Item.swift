//
//  Item.swift
//  QuickSearch
//
//  Created by Yu Takahashi on 12/12/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
