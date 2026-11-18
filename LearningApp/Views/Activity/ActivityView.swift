//
//  ActivityView.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import SwiftUI

struct ActivityView: View {
    @Environment(ActivityViewModel.self) private var viewModel
    @Environment(\.scenePhase) private var scenePhase
    @State private var showGoal = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 24) {
                    WeekStripView()

                    HStack {
                        StreakCardView(
                            systemImage: "flame.fill",
                            color: .orange,
                            count: viewModel.data.learnedCount,
                            title: "Learned"
                        )
                        StreakCardView(
                            systemImage: "snowflake",
                            color: .cyan,
                            count: viewModel.data.freezedCount,
                            title: "Freezed"
                        )
                    }

                    // The buttons while the goal is running, a message when it is over
                    switch viewModel.goalStatus {
                    case .inProgress:
                        buttons
                    case .reached:
                        GoalCompletedView(isReached: true) { showGoal = true }
                    case .missed:
                        GoalCompletedView(isReached: false) { showGoal = true }
                    }
                }
                .padding()
            }
            .navigationTitle("Activity")
            .navigationSubtitle(viewModel.now.formatted(.dateTime.weekday(.wide).day().month(.wide)))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CalendarView(activity: viewModel)
                    } label: {
                        Label("Calendar", systemImage: "calendar")
                    }
                }
                // The spacer splits the two buttons into two separate glass circles
                ToolbarSpacer(.fixed, placement: .topBarTrailing)
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Learning Goal", systemImage: "pencil.circle") {
                        showGoal = true
                    }
                }
            }
            .sheet(isPresented: $showGoal) {
                // While the goal is running, changing it starts the streak over
                LearningGoalView(
                    goal: viewModel.data.goal,
                    needsConfirmation: viewModel.goalStatus == .inProgress
                )
            }
        }
        // Runs when the app opens and every time it comes back to the foreground
        .onChange(of: scenePhase, initial: true) {
            if scenePhase == .active {
                viewModel.refresh()
            }
        }
        // Runs when the day changes at 12 AM while the app is open
        .task {
            for await _ in NotificationCenter.default.notifications(named: .NSCalendarDayChanged) {
                viewModel.refresh()
            }
        }
    }

    private var buttons: some View {
        VStack(spacing: 24) {
            LogButtonView(isLogged: viewModel.isLearnedToday) {
                viewModel.logAsLearned()
            }

            VStack(spacing: 8) {
                Button {
                    viewModel.freezeDay()
                } label: {
                    Text(viewModel.isFreezeFinished ? "Freezed for a day" : "Freeze for a day")
                        .frame(maxWidth: .infinity)
                }
                .controlSize(.large)
                // Cyan glass when it can be pressed, plain dark glass when it can't
                .buttonStyle(.glass(viewModel.canFreeze ? .regular.tint(.cyan) : .regular))
                .foregroundStyle(viewModel.canFreeze ? .white : .secondary)
                .frame(maxWidth: 280)
                .disabled(!viewModel.canFreeze)

                Text("\(viewModel.data.freezedCount) out of \(viewModel.data.goal.duration.maxFreezes) Freezes used")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    ActivityView()
        .environment(ActivityViewModel.preview)
}

#Preview("Logged today") {
    ActivityView()
        .environment(ActivityViewModel.previewLogged)
}

#Preview("Freezed today") {
    ActivityView()
        .environment(ActivityViewModel.previewFreezed)
}

#Preview("No freezes left") {
    ActivityView()
        .environment(ActivityViewModel.previewNoFreezes)
}

#Preview("Goal reached") {
    ActivityView()
        .environment(ActivityViewModel.previewReached)
}

#Preview("Goal missed") {
    ActivityView()
        .environment(ActivityViewModel.previewMissed)
}
