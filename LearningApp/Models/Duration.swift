//
//  Duration.swift
//  MyApp
//
//  Created by Ghadeer on 09/11/2026.
//

import Foundation

/// How long the learner wants to keep a learning streak going.
enum Duration: String, Codable, CaseIterable {
    case week
    case month
    case year

    /// Maximum number of freezes allowed for this duration.
    var maxFreezes: Int {
        // TODO: Return 2 for week, 8 for month, 96 for year.
        return 0
    }

    /// Number of days the goal lasts.
    var numberOfDays: Int {
        // TODO: Return 7 for week, the number of days in a month for month, 365 for year.
        return 0
    }

    /// Display title for the duration.
    var title: String {
        // TODO: Return a user-facing title for each case (e.g. "Week", "Month", "Year").
        return ""
    }
}
