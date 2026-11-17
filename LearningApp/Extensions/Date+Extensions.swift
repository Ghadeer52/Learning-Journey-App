//
//  Date+Extensions.swift
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
}
