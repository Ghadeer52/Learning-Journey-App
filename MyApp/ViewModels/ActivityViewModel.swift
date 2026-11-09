import Foundation
import Observation

@MainActor
@Observable
final class ActivityViewModel {
    // MARK: - Dependencies

    private let storage: ActivityStorage
    private let streakManager: StreakManager

    // MARK: - State

    var data: ActivityData

    // MARK: - Init

    init(storage: ActivityStorage, streakManager: StreakManager) {
        self.storage = storage
        self.streakManager = streakManager
        // TODO: Load saved data from `storage`; fall back to a default ActivityData when nothing is saved.
        self.data = ActivityData(
            goal: LearningGoal(topic: "", duration: .week, startDate: Date()),
            streakCount: 0,
            freezesUsed: 0,
            lastActivityDate: nil,
            loggedDays: [:]
        )
    }

    // MARK: - Computed properties

    /// Whether today is already logged. Log and Freeze are disabled once true; re-enables at 12 AM.
    var isLoggedToday: Bool {
        // TODO: Ask streakManager.isLoggedToday(lastActivity:now:).
        return false
    }

    /// Whether the Freeze button is disabled (today is logged or all freezes are used).
    var isFreezeDisabled: Bool {
        // TODO: Return the opposite of streakManager.canFreeze(freezesUsed:duration:isLoggedToday:).
        return true
    }

    /// Streak label, e.g. "1 Day" or "5 Days".
    var streakText: String {
        // TODO: Use "Day" when streakCount is 1, "Days" otherwise.
        return ""
    }

    /// Freeze label, e.g. "1 Day Frozen" or "3 Days Frozen".
    var freezeText: String {
        // TODO: Use "Day" when the freeze count is 1, "Days" otherwise.
        return ""
    }

    /// Freezes used out of the maximum, e.g. "1 out of 2 Freezes used".
    var freezesUsedText: String {
        // TODO: Combine freezesUsed with goal.duration.maxFreezes.
        return ""
    }

    /// Whether the learning goal has been completed.
    var isGoalCompleted: Bool {
        // TODO: Ask streakManager.isGoalCompleted(goal:now:).
        return false
    }

    // MARK: - Actions

    /// Logs today as learned.
    func logAsLearned() {
        // TODO: Increase streakCount, mark today as .learned in loggedDays, update lastActivityDate, then save.
    }

    /// Freezes today, keeping the streak alive.
    func freezeDay() {
        // TODO: Increase freezesUsed, mark today as .freezed, update lastActivityDate, do NOT increase the learned count, then save.
    }

    /// Resets the streak if more than 32 hours passed since the last activity.
    func checkStreakReset() {
        // TODO: If streakManager.shouldResetStreak(lastActivity:now:) is true, reset streakCount, then save.
    }

    /// Replaces the learning goal.
    func updateGoal(_ goal: LearningGoal) {
        // TODO: Set the new goal, reset the streak, then save.
    }

    /// The logged status for a given date, if any.
    func status(for date: Date) -> DayStatus? {
        // TODO: Look up date.dayKey in data.loggedDays.
        return nil
    }
}
