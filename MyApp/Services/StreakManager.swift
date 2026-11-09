import Foundation

/// Pure rules for streaks, freezes and goal completion.
struct StreakManager {
    /// Whether the streak should reset.
    func shouldResetStreak(lastActivity: Date?, now: Date) -> Bool {
        // TODO: Return true when more than 32 hours have passed since `lastActivity`.
        return false
    }

    /// Whether today has already been logged as learned or freezed.
    func isLoggedToday(lastActivity: Date?, now: Date) -> Bool {
        // TODO: Return true if `lastActivity` is on the same calendar day as `now`. Becomes false again after midnight (12 AM).
        return false
    }

    /// Whether the learner is still allowed to freeze today.
    func canFreeze(freezesUsed: Int, duration: Duration, isLoggedToday: Bool) -> Bool {
        // TODO: Return false when today is logged or freezesUsed has reached duration.maxFreezes (2 per week, 8 per month, 96 per year).
        return false
    }

    /// Whether the learning goal's duration has fully elapsed.
    func isGoalCompleted(goal: LearningGoal, now: Date) -> Bool {
        // TODO: Return true when `now` is past startDate + goal.duration.numberOfDays.
        return false
    }
}
