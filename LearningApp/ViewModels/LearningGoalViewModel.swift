//
//  LearningGoalViewModel.swift
//  LearningApp
//
//  Created by Ghadeer on 18/11/2026.
//

import Foundation
import Observation

@Observable
class LearningGoalViewModel {
    private let original: LearningGoal

    // True while the goal is running: saving then needs a real change
    private let requiresChange: Bool

    var topic: String
    var duration: Duration

    init(goal: LearningGoal, requiresChange: Bool) {
        original = goal
        self.requiresChange = requiresChange
        topic = goal.topic
        duration = goal.duration
    }

    // The topic without spaces at the start and end
    var cleanTopic: String {
        topic.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    // True when the learner changed the topic or the duration
    var hasChanges: Bool {
        cleanTopic != original.topic || duration != original.duration
    }

    // The check button: a topic is needed, and a change too while the goal is running
    var canSave: Bool {
        if cleanTopic.isEmpty {
            return false
        }
        return !requiresChange || hasChanges
    }
}
