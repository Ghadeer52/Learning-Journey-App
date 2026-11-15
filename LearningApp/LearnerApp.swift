//
//  LearnerApp.swift
//  LearningApp
//
//  Created by Ghadeer on 09/11/2026.
//

import SwiftUI

@main
struct LearnerApp: App {
    var body: some Scene {
        WindowGroup {
            // Temporary placeholder. We build the real screens in later steps.
            //Text("Learning Journey")
            Text(experiment())

        }
    }
    private func experiment() -> String {
        let goal = LearningGoal(topic: "Swift", duration: .week, startDate: Date())
        let original = ActivityData(goal: goal)
        var copy = original
        copy.learnedCount = 5
        return "original: \(original.learnedCount), copy: \(copy.learnedCount)"
    }
}
