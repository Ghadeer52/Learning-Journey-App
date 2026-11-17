//
//  LearnerApp.swift
//  LearningApp
//
//  Created by Ghadeer on 09/11/2026.
//

import SwiftUI

@main
struct LearnerApp: App {
    private func experiment() -> String {
        let viewModel = ActivityViewModel(storage: MockStorageService())
        viewModel.setGoal(topic: "Swift", duration: .week)
        viewModel.logAsLearned()
        viewModel.freezeDay() // does nothing, today is already logged
        return "learned \(viewModel.data.learnedCount), freezed \(viewModel.data.freezedCount), logged today: \(viewModel.isLoggedToday)"
    }
    var body: some Scene {
        WindowGroup {
            // Temporary text. The real screens come in later steps.
            Text("Learning Journey")
        }
    }
}
