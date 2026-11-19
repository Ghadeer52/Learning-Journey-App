//
//  Untitled.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import Testing
import Foundation
@testable import Learning_Journey

struct StreakManagerTests {
    let calendar: Calendar
    let manager: StreakManager

    init() {
        // A fixed calendar, so the tests give the same result on every Mac.
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .gmt
        self.calendar = calendar
        self.manager = StreakManager(calendar: calendar)
    }

    /// Builds a date in 2026 (November unless told otherwise). #require stops the test if the date is invalid.
    private func date(month: Int = 11, day: Int, hour: Int, minute: Int = 0) throws -> Date {
        let parts = DateComponents(year: 2026, month: month, day: day, hour: hour, minute: minute)
        return try #require(calendar.date(from: parts))
    }

    // MARK: - 32-hour rule
    // Last log on Nov 10 means the clock starts Nov 11 at 12 AM, so the deadline is Nov 12 at 8 AM.

    @Test func noResetWhenNothingWasLogged() throws {
        let now = try date(day: 12, hour: 9)
        #expect(manager.shouldResetStreak(lastActivity: nil, now: now) == false)
    }

    @Test func skippingOneDayKeepsTheStreak() throws {
        let last = try date(day: 10, hour: 9)
        let now = try date(day: 12, hour: 7, minute: 59)
        #expect(manager.shouldResetStreak(lastActivity: last, now: now) == false)
    }

    @Test func exactly32HoursDoesNotReset() throws {
        let last = try date(day: 10, hour: 9)
        let now = try date(day: 12, hour: 8)
        #expect(manager.shouldResetStreak(lastActivity: last, now: now) == false)
    }

    @Test func resetsAfter32Hours() throws {
        let last = try date(day: 10, hour: 9)
        let now = try date(day: 12, hour: 8, minute: 1)
        #expect(manager.shouldResetStreak(lastActivity: last, now: now) == true)
    }

    @Test(arguments: [0, 23])
    func timeOfLogDoesNotMatter(hour: Int) throws {
        let last = try date(day: 10, hour: hour, minute: 30)
        let before = try date(day: 12, hour: 7, minute: 59)
        let after = try date(day: 12, hour: 8, minute: 1)
        #expect(manager.shouldResetStreak(lastActivity: last, now: before) == false)
        #expect(manager.shouldResetStreak(lastActivity: last, now: after) == true)
    }

    // MARK: - Midnight rule

    @Test func loggedTodayWhenSameDay() throws {
        let last = try date(day: 10, hour: 23)
        let now = try date(day: 10, hour: 23, minute: 59)
        #expect(manager.isLoggedToday(lastActivity: last, now: now) == true)
    }

    @Test func buttonsComeBackAfterMidnight() throws {
        let last = try date(day: 10, hour: 23)
        let now = try date(day: 11, hour: 0, minute: 1)
        #expect(manager.isLoggedToday(lastActivity: last, now: now) == false)
    }

    @Test func notLoggedTodayWhenNothingWasLogged() throws {
        let now = try date(day: 11, hour: 9)
        #expect(manager.isLoggedToday(lastActivity: nil, now: now) == false)
    }

    // MARK: - Freeze limits

    @Test(arguments: Duration.allCases)
    func canFreezeBelowTheLimit(duration: Duration) {
        let used = duration.maxFreezes - 1
        #expect(manager.canFreeze(freezedCount: used, duration: duration, isLoggedToday: false) == true)
    }

    @Test(arguments: Duration.allCases)
    func cannotFreezeAtTheLimit(duration: Duration) {
        let used = duration.maxFreezes
        #expect(manager.canFreeze(freezedCount: used, duration: duration, isLoggedToday: false) == false)
    }

    @Test(arguments: Duration.allCases)
    func cannotFreezeWhenTodayIsLogged(duration: Duration) {
        #expect(manager.canFreeze(freezedCount: 0, duration: duration, isLoggedToday: true) == false)
    }

    @Test func freezeLimitsMatchTheDesign() {
        #expect(Duration.week.maxFreezes == 2)
        #expect(Duration.month.maxFreezes == 8)
        #expect(Duration.year.maxFreezes == 96)
    }

    // MARK: - Goal status
    // A week goal that starts on Nov 10 covers Nov 10 to Nov 16 and ends on Nov 17 at 12 AM.

    /// One entry per day. Even days are freezed, odd days are learned, so both kinds are counted.
    private func loggedDays(from days: ClosedRange<Int>) throws -> [String: DayStatus] {
        var result: [String: DayStatus] = [:]
        for day in days {
            let key = try date(day: day, hour: 12).dayKey(calendar: calendar)
            result[key] = day.isMultiple(of: 2) ? .frozen : .learned
        }
        return result
    }

    private func weekGoal() throws -> LearningGoal {
        let start = try date(day: 10, hour: 15)
        return LearningGoal(topic: "Swift", duration: .week, startDate: start)
    }

    @Test func reachedWhenEveryDayIsLoggedOrFreezed() throws {
        let days = try loggedDays(from: 10...16)
        let now = try date(day: 16, hour: 21)
        #expect(manager.goalStatus(goal: try weekGoal(), loggedDays: days, now: now) == .reached)
    }

    @Test func inProgressWhileADayIsStillOpen() throws {
        let days = try loggedDays(from: 10...15)
        let now = try date(day: 16, hour: 21)
        #expect(manager.goalStatus(goal: try weekGoal(), loggedDays: days, now: now) == .inProgress)
    }

    @Test func missedWhenThePeriodEndsWithAGap() throws {
        let days = try loggedDays(from: 10...15)
        let now = try date(day: 17, hour: 0)
        #expect(manager.goalStatus(goal: try weekGoal(), loggedDays: days, now: now) == .missed)
    }

    @Test func daysBeforeTheStartDoNotCount() throws {
        // Nov 5 to 9 are old days, so only 6 of the 7 days in the period are logged.
        let days = try loggedDays(from: 5...15)
        let now = try date(day: 16, hour: 21)
        #expect(manager.goalStatus(goal: try weekGoal(), loggedDays: days, now: now) == .inProgress)
    }

    @Test func monthGoalFromThe31stEndsOnTheLastDayOfFebruary() throws {
        let start = try date(month: 1, day: 31, hour: 12)
        let goal = LearningGoal(topic: "Swift", duration: .month, startDate: start)
        let beforeEnd = try date(month: 2, day: 27, hour: 12)
        let atEnd = try date(month: 2, day: 28, hour: 0)
        #expect(manager.goalStatus(goal: goal, loggedDays: [:], now: beforeEnd) == .inProgress)
        #expect(manager.goalStatus(goal: goal, loggedDays: [:], now: atEnd) == .missed)
    }
}
