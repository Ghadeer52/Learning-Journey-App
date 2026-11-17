//
//  OnboardingViewModel.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import Foundation
import Observation

@Observable
class OnboardingViewModel {
    var topic = ""
    var duration = Duration.week

    // The topic without spaces at the start and end
    var cleanTopic: String {
        topic.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // Start Learning only works when something was typed
    var canStart: Bool {
        !cleanTopic.isEmpty
    }
}
