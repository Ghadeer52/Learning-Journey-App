//
//  MockStorageService.swift
//  MyApp
//
//  Created by Ghadeer on 09/11/2026.
//

import Foundation

/// In-memory storage, intended for previews and tests.
final class MockStorageService: ActivityStorage {
    private var storedData: ActivityData?

    init(storedData: ActivityData? = nil) {
        self.storedData = storedData
    }

    func save(_ data: ActivityData) {
        // TODO: Keep `data` in memory by assigning it to `storedData`.
    }

    func load() -> ActivityData? {
        // TODO: Return the in-memory `storedData`.
        return nil
    }
}
