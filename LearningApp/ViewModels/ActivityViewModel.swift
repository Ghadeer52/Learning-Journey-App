//
//  ActivityViewModel.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import Foundation
import Observation

@Observable
class ActivityViewModel {
    private let storage: ActivityStorage
    private let streakManager = StreakManager()

    var data: ActivityData
    var now = Date()

    init(storage: ActivityStorage) {
        self.storage = storage
        // Nothing saved yet: start with an empty goal until onboarding sets a real one
        self.data = storage.load() ?? ActivityData(goal: LearningGoal(topic: "", duration: .week, startDate: Date()))
    }

    var isLoggedToday: Bool {
        streakManager.isLoggedToday(lastActivity: data.lastActivityDate, now: now)
    }

    // True when today was logged as learned (a freezed day can still be logged)
    var isLearnedToday: Bool {
        status(for: now) == .learned
    }

    var canFreeze: Bool {
        streakManager.canFreeze(freezedCount: data.freezedCount, duration: data.goal.duration, isLoggedToday: isLoggedToday)
    }

    var goalStatus: GoalStatus {
        streakManager.goalStatus(goal: data.goal, loggedDays: data.loggedDays, now: now)
    }

    // True when today was freezed or every freeze of the goal is used
    var isFreezeFinished: Bool {
        let isFreezedToday = status(for: now) == .frozen
        return isFreezedToday || data.freezedCount >= data.goal.duration.maxFreezes
    }

    // The seven days of the current week
    var weekDays: [Date] {
        let calendar = Calendar.current
        guard let week = calendar.dateInterval(of: .weekOfYear, for: now) else { return [] }
        return (0..<7).compactMap { calendar.date(byAdding: .day, value: $0, to: week.start) }
    }

    // What the learner did on a given day, or nil if nothing
    func status(for date: Date) -> DayStatus? {
        data.loggedDays[date.dayKey()]
    }

    // Updates the time and resets the streak if too many hours passed
    func refresh() {
        now = Date()
        let shouldReset = streakManager.shouldResetStreak(lastActivity: data.lastActivityDate, now: now)
        if shouldReset && data.learnedCount > 0 {
            data.learnedCount = 0
            storage.save(data)
        }
    }

    func logAsLearned() {
        refresh()
        guard !isLearnedToday else { return }

        // A freeze made earlier today is given back
        if status(for: now) == .frozen && data.freezedCount > 0 {
            data.freezedCount -= 1
        }
        data.learnedCount += 1
        markToday(.learned)
    }

    func freezeDay() {
        refresh()
        guard canFreeze else { return }
        data.freezedCount += 1
        markToday(.frozen)
    }

    // Used for the first goal, a changed goal, and a new goal after finishing
    func setGoal(topic: String, duration: Duration) {
        now = Date()
        data.goal = LearningGoal(topic: topic, duration: duration, startDate: now)
        data.learnedCount = 0
        data.freezedCount = 0
        data.lastActivityDate = nil
        data.loggedDays[now.dayKey()] = nil // today starts fresh, older days stay
        storage.save(data)
    }

    private func markToday(_ status: DayStatus) {
        data.loggedDays[now.dayKey()] = status
        data.lastActivityDate = now
        storage.save(data)
    }
}
