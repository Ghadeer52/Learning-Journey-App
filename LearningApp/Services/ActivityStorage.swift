//
//  ActivityStorage.swift
//  MyApp
//
//  Created by Ghadeer on 09/11/2026.
//

import Foundation

/// Abstraction over where activity data is stored.
protocol ActivityStorage {
    func save(_ data: ActivityData)
    func load() -> ActivityData?
}
