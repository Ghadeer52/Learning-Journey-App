//
//  LearningGoal.swift
//  LearningApp
//
//  Created by Ghadeer on 15/11/2026.
//

import Foundation

/// What the learner is studying and for how long.
struct LearningGoal: Codable {
    var topic: String
    var duration: Duration
    var startDate: Date
}
