//
//  preview.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import Foundation

// Sample view models, only for previews
extension ActivityViewModel {
    // A week goal that started today, with some days logged before
    static var preview: ActivityViewModel {
        var data = ActivityData(goal: LearningGoal(topic: "Swift", duration: .week, startDate: .now))
        data.learnedCount = 3
        data.freezedCount = 1

        for daysAgo in 1...4 {
            if let day = Calendar.current.date(byAdding: .day, value: -daysAgo, to: .now) {
                data.loggedDays[day.dayKey()] = daysAgo == 2 ? .frozen : .learned
            }
        }
        return ActivityViewModel(storage: MockStorageService(stored: data))
    }

    // The same sample, but today is already logged as learned
    static var previewLogged: ActivityViewModel {
        let viewModel = preview
        viewModel.logAsLearned()
        return viewModel
    }

    // The same sample, but today is freezed
    static var previewFreezed: ActivityViewModel {
        let viewModel = preview
        viewModel.freezeDay()
        return viewModel
    }

    // The same sample, but every freeze of the week is used
    static var previewNoFreezes: ActivityViewModel {
        let viewModel = preview
        viewModel.data.freezedCount = 2
        return viewModel
    }

    // About ten months of history, for the calendar
    static var previewLongHistory: ActivityViewModel {
        var data = ActivityData(goal: LearningGoal(topic: "Swift", duration: .year, startDate: .now))
        for daysAgo in 1...300 where !daysAgo.isMultiple(of: 5) {
            if let day = Calendar.current.date(byAdding: .day, value: -daysAgo, to: .now) {
                data.loggedDays[day.dayKey()] = daysAgo.isMultiple(of: 7) ? .frozen : .learned
            }
        }
        return ActivityViewModel(storage: MockStorageService(stored: data))
    }

    // A week goal where every day is logged
    static var previewReached: ActivityViewModel {
        sample(startedDaysAgo: 6, loggedDaysAgo: [0, 1, 2, 3, 4, 5, 6])
    }

    // A week goal that ended with three empty days
    static var previewMissed: ActivityViewModel {
        sample(startedDaysAgo: 8, loggedDaysAgo: [2, 3, 5, 6])
    }

    private static func sample(startedDaysAgo: Int, loggedDaysAgo: [Int]) -> ActivityViewModel {
        let calendar = Calendar.current
        let start = calendar.date(byAdding: .day, value: -startedDaysAgo, to: .now) ?? .now
        var data = ActivityData(goal: LearningGoal(topic: "Swift", duration: .week, startDate: start))
        data.learnedCount = 3
        data.freezedCount = 2

        for daysAgo in loggedDaysAgo {
            if let day = calendar.date(byAdding: .day, value: -daysAgo, to: .now) {
                data.loggedDays[day.dayKey()] = daysAgo.isMultiple(of: 3) ? .frozen : .learned
            }
        }
        return ActivityViewModel(storage: MockStorageService(stored: data))
    }
}
