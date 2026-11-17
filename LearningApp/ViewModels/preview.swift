//
//  Untitled.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import Foundation

extension ActivityViewModel {
    // A view model with sample data, only for previews
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
}
