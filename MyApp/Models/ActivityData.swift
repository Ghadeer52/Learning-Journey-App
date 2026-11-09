import Foundation

/// Everything that is persisted about the learner's progress.
struct ActivityData: Codable, Equatable {
    var goal: LearningGoal
    var streakCount: Int
    var freezesUsed: Int
    var lastActivityDate: Date?

    /// Keys are days formatted as "yyyy-MM-dd" (see `Date.dayKey`).
    var loggedDays: [String: DayStatus]
}
