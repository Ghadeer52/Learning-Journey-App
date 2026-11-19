//
//  CalendarViewModel.swift
//  LearningApp
//
//  Created by Ghadeer on 18/11/2026.
//

import Foundation
import Observation

@Observable
class CalendarViewModel {
    private let activity: ActivityViewModel
    private let calendar = Calendar.current

    init(activity: ActivityViewModel) {
        self.activity = activity
    }

    // The first day of every month, from the oldest day we show until the newest.
    // A week, month or year goal shows all of its days, even the ones still to come.
    var months: [Date] {
        let goal = activity.data.goal
        let goalStart = calendar.startOfDay(for: goal.startDate)
        let goalEnd = calendar.date(byAdding: goal.duration.calendarComponent, value: 1, to: goalStart) ?? goalStart
        // The goal ends one period later, but that last moment is not part of it
        let lastGoalDay = calendar.date(byAdding: .day, value: -1, to: goalEnd) ?? goalEnd

        let first = startOfMonth(for: min(firstLoggedDay, goalStart))
        let last = startOfMonth(for: max(activity.now, lastGoalDay))
        let count = calendar.dateComponents([.month], from: first, to: last).month ?? 0
        return (0...count).compactMap { calendar.date(byAdding: .month, value: $0, to: first) }
    }

    // The month that is open when the calendar appears
    var currentMonth: Date {
        startOfMonth(for: activity.now)
    }

    // The names above the days, starting with the first day of the week
    var weekdayNames: [String] {
        let names = calendar.shortWeekdaySymbols
        let start = calendar.firstWeekday - 1
        return Array(names[start...] + names[..<start])
    }

    // The days of a month. nil is an empty cell before the 1st.
    func days(in month: Date) -> [Date?] {
        guard
            let interval = calendar.dateInterval(of: .month, for: month),
            let dayCount = calendar.range(of: .day, in: .month, for: month)?.count
        else {
            return []
        }

        let weekday = calendar.component(.weekday, from: interval.start)
        let emptyCells = (weekday - calendar.firstWeekday + 7) % 7
        let days = (0..<dayCount).map { calendar.date(byAdding: .day, value: $0, to: interval.start) }
        return Array<Date?>(repeating: nil, count: emptyCells) + days
    }

    func status(for day: Date) -> DayStatus? {
        activity.status(for: day)
    }

    func isToday(_ day: Date) -> Bool {
        calendar.isDate(day, inSameDayAs: activity.now)
    }

    // The earliest day in the saved history, or today when there is none
    private var firstLoggedDay: Date {
        let style = Date.ISO8601FormatStyle(timeZone: calendar.timeZone).year().month().day()
        let days = activity.data.loggedDays.keys.compactMap { try? style.parse($0) }
        return days.min() ?? activity.now
    }

    private func startOfMonth(for date: Date) -> Date {
        calendar.dateInterval(of: .month, for: date)?.start ?? date
    }
}
