//
//  StreakManeger.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import Foundation

/// The rules for streaks and freezes.
/// It never reads the clock itself: the current date is always passed in,
/// so every rule can be tested with pretend times.
struct StreakManager {
    /// Hours the learner has, counted from 12 AM after their last logged day.
    private let streakHours = 32.0

    private let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    /// True when the streak should go back to 0.
    func shouldResetStreak(lastActivity: Date?, now: Date) -> Bool {
        // Nothing logged yet, so there is no streak to lose.
        guard let lastActivity else { return false }

        // The 32-hour clock starts at 12 AM on the day after the last log.
        let startOfLastDay = calendar.startOfDay(for: lastActivity)
        guard let clockStart = calendar.date(byAdding: .day, value: 1, to: startOfLastDay) else {
            return false
        }

        return now.hours(since: clockStart) > streakHours
    }

    /// True when today is already logged (learned or freezed).
    func isLoggedToday(lastActivity: Date?, now: Date) -> Bool {
        guard let lastActivity else { return false }
        return lastActivity.isSameDay(as: now, calendar: calendar)
    }

    /// True when the learner may freeze today.
    func canFreeze(freezedCount: Int, duration: Duration, isLoggedToday: Bool) -> Bool {
        if isLoggedToday {
            return false
        }
        return freezedCount < duration.maxFreezes
    }
}
