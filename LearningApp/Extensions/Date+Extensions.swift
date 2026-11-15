//
//  Untitled.swift
//  LearningApp
//
//  Created by Ghadeer on 15/11/2026.
//
import Foundation

extension Date {
    /// The day as "yyyy-MM-dd", used as a key in `ActivityData.loggedDays`.
    func dayKey(calendar: Calendar = .current) -> String {
        // Use the learner's time zone, otherwise 1 AM could count as the previous day.
        let style = Date.ISO8601FormatStyle(timeZone: calendar.timeZone)
            .year()
            .month()
            .day()
        return formatted(style)
    }

    /// Whether this date is on the same calendar day as another date.
    func isSameDay(as other: Date, calendar: Calendar = .current) -> Bool {
        return calendar.isDate(self, inSameDayAs: other)
    }

    /// Hours from an earlier date until this date, including fractions.
    func hours(since earlier: Date) -> Double {
        return timeIntervalSince(earlier) / 3600
    }
}

