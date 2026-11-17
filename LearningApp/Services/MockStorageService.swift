//
//  MockStorageService.swift
//  LearningApp
//
//  Created by Ghadeer on 15/11/2026.
//

import Foundation

/// A fake storage that keeps data in memory. Used for previews and tests.
final class MockStorageService: ActivityStorage {
    private var stored: ActivityData?

    init(stored: ActivityData? = nil) {
        self.stored = stored
    }

    func load() -> ActivityData? {
        return stored
    }

    func save(_ activityData: ActivityData) {
        stored = activityData
    }
}
