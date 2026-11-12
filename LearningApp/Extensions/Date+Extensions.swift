//
//  Date+Extensions.swift
//  MyApp
//
//  Created by Ghadeer on 09/11/2026.
//

import Foundation

extension Date {
    /// The date formatted as "yyyy-MM-dd", used as a key in `ActivityData.loggedDays`.
    var dayKey: String {
        // TODO: Format the date as "yyyy-MM-dd".
        return ""
    }

    /// Whether the date falls on today's calendar day.
    var isToday: Bool {
        // TODO: Return true if the date is in today's calendar day.
        return false
    }

    /// Number of hours between `date` and this date.
    func hoursSince(_ date: Date) -> Double {
        // TODO: Return the number of hours elapsed from `date` to self.
        return 0
    }

    /// The first moment of the month containing this date.
    var startOfMonth: Date {
        // TODO: Return the start of the month containing this date.
        return self
    }
}
