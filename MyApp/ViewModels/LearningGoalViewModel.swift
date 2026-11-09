import Foundation
import Observation

@MainActor
@Observable
final class LearningGoalViewModel {
    var topic: String = ""
    var selectedDuration: Duration = .week
    var showUpdateAlert: Bool = false

    func confirmUpdate() {
        // TODO: Build a new LearningGoal and call ActivityViewModel.updateGoal(_:) (this resets the streak), then close the alert.
    }

    func dismiss() {
        // TODO: Hide the update alert without changing the goal.
    }
}
