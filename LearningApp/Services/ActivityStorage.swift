//
//  ActivityStorage.swift
//  LearningApp
//
//  Created by Ghadeer on 15/11/2026.
//

import Foundation

/// Anything that can load and save the learner's data.
protocol ActivityStorage {
    /// Returns the saved data, or nil when nothing was saved yet (first launch).
    func load() -> ActivityData?

    /// Saves the learner's data.
    func save(_ activityData: ActivityData)
}
