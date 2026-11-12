//
//  StreakManagerTests.swift
//  MyAppTests
//
//  Created by Ghadeer on 10/11/2026.
//


import Testing
import Foundation
@testable import MyApp

struct DurationTests {
    @Test func maxFreezes() {
        #expect(Duration.week.maxFreezes == 2)
        #expect(Duration.month.maxFreezes == 8)
        #expect(Duration.year.maxFreezes == 96)
    }

    @Test func numberOfDays() {
        #expect(Duration.week.numberOfDays == 7)
        #expect((28...31).contains(Duration.month.numberOfDays))
        #expect(Duration.year.numberOfDays == 365)
    }

    @Test(arguments: Duration.allCases)
    func titleIsNotEmpty(duration: Duration) {
        #expect(!duration.title.isEmpty)
    }
}

struct StreakManagerTests {
    let manager = StreakManager()
    let calendar = Calendar.current
    let now = Date()

    // MARK: - shouldResetStreak

    @Test func noResetWithin32Hours() {
        let last = now.addingTimeInterval(-31 * 3600)
        #expect(manager.shouldResetStreak(lastActivity: last, now: now) == false)
    }

    @Test func resetAfter32Hours() {
        let last = now.addingTimeInterval(-33 * 3600)
        #expect(manager.shouldResetStreak(lastActivity: last, now: now) == true)
    }

    // MARK: - isLoggedToday

    @Test func loggedTodayWhenSameDay() {
        let startOfToday = calendar.startOfDay(for: now)
        #expect(manager.isLoggedToday(lastActivity: startOfToday, now: now) == true)
    }

    @Test func notLoggedTodayWhenNil() {
        #expect(manager.isLoggedToday(lastActivity: nil, now: now) == false)
    }

    @Test func notLoggedTodayAfterMidnight() {
        let startOfToday = calendar.startOfDay(for: now)
        let lastNight = startOfToday.addingTimeInterval(-60)
        #expect(manager.isLoggedToday(lastActivity: lastNight, now: now) == false)
    }

    // MARK: - canFreeze

    @Test func canFreezeBelowLimit() {
        #expect(manager.canFreeze(freezesUsed: 1, duration: .week, isLoggedToday: false) == true)
    }

    @Test func cannotFreezeAtLimit() {
        #expect(manager.canFreeze(freezesUsed: 2, duration: .week, isLoggedToday: false) == false)
        #expect(manager.canFreeze(freezesUsed: 8, duration: .month, isLoggedToday: false) == false)
        #expect(manager.canFreeze(freezesUsed: 96, duration: .year, isLoggedToday: false) == false)
    }

    @Test func cannotFreezeWhenLoggedToday() {
        #expect(manager.canFreeze(freezesUsed: 0, duration: .week, isLoggedToday: true) == false)
    }

    // MARK: - isGoalCompleted

    @Test func goalNotCompletedBeforeDurationEnds() {
        let start = calendar.date(byAdding: .day, value: -3, to: now)!
        let goal = LearningGoal(topic: "Swift", duration: .week, startDate: start)
        #expect(manager.isGoalCompleted(goal: goal, now: now) == false)
    }

    @Test func goalCompletedAfterDurationEnds() {
        let start = calendar.date(byAdding: .day, value: -8, to: now)!
        let goal = LearningGoal(topic: "Swift", duration: .week, startDate: start)
        #expect(manager.isGoalCompleted(goal: goal, now: now) == true)
    }
}
