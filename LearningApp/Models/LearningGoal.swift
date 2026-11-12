//
//  LearningGoal.swift
//  MyApp
//
//  Created by Ghadeer on 09/11/2026.
//

import Foundation

/// What the learner is studying and for how long.
struct LearningGoal: Codable, Equatable {
    var topic: String
    var duration: Duration
    var startDate: Date
}
