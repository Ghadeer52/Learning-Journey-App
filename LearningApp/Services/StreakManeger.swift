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
    private let streakHours = 32

    private let calendar: Calendar

    init(calendar: Calendar = .current) {
        self.calendar = calendar
    }

    /// True when the streak should go back to 0.
    func shouldResetStreak(lastActivity: Date?, now: Date) -> Bool {
        // Nothing logged yet, so there is no streak to lose.
        guard let lastActivity else { return false }

        // Deadline = 12 AM on the day after the last log, plus 32 hours.
        let startOfLastDay = calendar.startOfDay(for: lastActivity)
        let afterLastDay = DateComponents(day: 1, hour: streakHours)
        guard let deadline = calendar.date(byAdding: afterLastDay, to: startOfLastDay) else {
            return false
        }

        return now > deadline
    }

    /// True when today is already logged (learned or freezed).
    func isLoggedToday(lastActivity: Date?, now: Date) -> Bool {
        guard let lastActivity else { return false }
        return calendar.isDate(lastActivity, inSameDayAs: now)
    }

    /// True when the learner may freeze today.
    func canFreeze(freezedCount: Int, duration: Duration, isLoggedToday: Bool) -> Bool {
        if isLoggedToday {
            return false
        }
        return freezedCount < duration.maxFreezes
    }

    /// Where the learner stands with the goal.
    /// Reached: every day of the period has an entry (learned or freezed).
    /// Missed: the period is over and at least one day is empty.
    func goalStatus(goal: LearningGoal, loggedDays: [String: DayStatus], now: Date) -> GoalStatus {
        // The period starts at 12 AM on the first day and ends (not included) one week/month/year later.
        let start = calendar.startOfDay(for: goal.startDate)
        guard
            let end = calendar.date(byAdding: goal.duration.calendarComponent, value: 1, to: start),
            let totalDays = calendar.dateComponents([.day], from: start, to: end).day
        else {
            return .inProgress
        }

        // "yyyy-MM-dd" keys sort in date order, so we can compare them as text.
        let startKey = start.dayKey(calendar: calendar)
        let endKey = end.dayKey(calendar: calendar)
        let loggedCount = loggedDays.keys.filter { $0 >= startKey && $0 < endKey }.count

        if loggedCount >= totalDays {
            return .reached
        }
        if now >= end {
            return .missed
        }
        return .inProgress
    }
}
