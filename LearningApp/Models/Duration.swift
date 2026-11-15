//
//  Duration.swift
//  LearningApp
//
//  Created by Ghadeer on 12/11/2026.
//

import Foundation

/// How long the learner wants to keep a learning streak going.
enum Duration: String, Codable, CaseIterable {
    case week
    case month
    case year

    /// How many freezes the learner may use during one goal period.
    var maxFreezes: Int {
        switch self {
        case .week:
            return 2
        case .month:
            return 8
        case .year:
            return 96
        }
    }

    /// The calendar unit that this goal lasts for (one of them).
    var calendarComponent: Calendar.Component {
        switch self {
        case .week:
            return .weekOfYear
        case .month:
            return .month
        case .year:
            return .year
        }
    }
}
