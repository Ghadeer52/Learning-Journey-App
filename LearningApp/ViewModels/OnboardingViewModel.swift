//
//  OnboardingViewModel.swift
//  MyApp
//
//  Created by Ghadeer on 09/11/2026.
//

import Foundation
import Observation

@MainActor
@Observable
final class OnboardingViewModel {
    var topic: String = ""
    var selectedDuration: Duration = .week

    func startLearning() {
        // TODO: Build a LearningGoal from topic and selectedDuration, pass it to the ActivityViewModel, and set hasOnboarded to true.
    }
}
