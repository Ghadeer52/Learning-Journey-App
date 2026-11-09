import SwiftUI

@main
struct LearnerApp: App {
    // Onboarding shows only on first launch.
    @AppStorage("hasOnboarded") private var hasOnboarded: Bool = false

    @State private var activityViewModel: ActivityViewModel

    init() {
        let storage = JSONStorageService()
        let streakManager = StreakManager()
        _activityViewModel = State(
            initialValue: ActivityViewModel(storage: storage, streakManager: streakManager)
        )
    }

    var body: some Scene {
        WindowGroup {
            // TODO: Show OnboardingView when hasOnboarded is false, otherwise ActivityView.
            Group {
                if hasOnboarded {
                    ActivityView()
                } else {
                    OnboardingView()
                }
            }
            .environment(activityViewModel)
        }
    }
}
