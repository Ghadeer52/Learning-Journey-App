import Foundation

/// What the learner is studying and for how long.
struct LearningGoal: Codable, Equatable {
    var topic: String
    var duration: Duration
    var startDate: Date
}
