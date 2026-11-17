//
//  GoalStatus.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import Foundation

/// Where the learner stands with their goal. It is worked out each time, never saved.
enum GoalStatus {
    case inProgress
    case reached
    case missed
}
