//
//  ActivityData.swift
//  LearningApp
//
//  Created by Ghadeer on 15/11/2026.
//

import Foundation

/// Everything the app saves between launches.
struct ActivityData: Codable {
    var goal: LearningGoal

    /// The current streak of learned days. Shown as "Days Learned".
    var learnedCount = 0

    /// Freezes used in this goal period.
    var freezedCount = 0

    /// When the learner last logged or froze. nil means nothing logged yet.
    var lastActivityDate: Date?

    /// Calendar history. Key is "yyyy-MM-dd", for example "2026-11-12".
    var loggedDays: [String: DayStatus] = [:]
}
