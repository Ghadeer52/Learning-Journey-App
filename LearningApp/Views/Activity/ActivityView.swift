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

    #if DEBUG
    @State private var showTimeMachine = false
    #endif

    var body: some View {
        NavigationStack {
            // Fixed layout when it fits, so the Spacers can center the circle.
            // Scrolling layout when it doesn't (for example very large text).
            ViewThatFits(in: .vertical) {
                content
                ScrollView {
                    content
                }
            }
            // The title and the two buttons are drawn in the page, on one row
            .toolbarVisibility(.hidden, for: .navigationBar)
            // The Freeze button stays at the bottom of the screen while the goal is running
            .safeAreaBar(edge: .bottom) {
                if viewModel.goalStatus == .inProgress {
                    freezeSection
                }
            }
            .sheet(isPresented: $showGoal) {
                // While the goal is running, changing it starts the streak over
                LearningGoalView(
                    goal: viewModel.data.goal,
                    needsConfirmation: viewModel.goalStatus == .inProgress
                )
            }
            #if DEBUG
            // Testing only. It does not exist in a release build.
            .confirmationDialog("Time machine (testing only)", isPresented: $showTimeMachine, titleVisibility: .visible) {
                Button("+ 1 hour") { viewModel.timeTravel(.hour, by: 1) }
                Button("+ 1 day") { viewModel.timeTravel(.day, by: 1) }
                Button("+ 2 days") { viewModel.timeTravel(.day, by: 2) }
                Button("+ 8 days") { viewModel.timeTravel(.day, by: 8) }
                Button("Back to real time", role: .destructive) { viewModel.resetTimeTravel() }
                Button("Cancel", role: .cancel) { }
            }
            #endif
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

    private var content: some View {
        VStack(spacing: 24) {
            header

            WeekStripView()

            HStack {
                StreakCardView(
                    systemImage: "flame.fill",
                    color: .gorange,
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

            // The Log circle takes the free space and sits in the middle of it.
            // On a small phone it shrinks to fit. When the goal is over, a message takes its place.
            switch viewModel.goalStatus {
            case .inProgress:
                GeometryReader { proxy in
                    let size = min(proxy.size.width * 0.7, proxy.size.height)
                    LogButtonView(isLogged: viewModel.isLearnedToday) {
                        viewModel.logAsLearned()
                    }
                    .frame(width: size, height: size)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
                .frame(minHeight: 200)
            case .reached:
                Spacer()
                GoalCompletedView(isReached: true) { showGoal = true }
                Spacer()
            case .missed:
                Spacer()
                GoalCompletedView(isReached: false) { showGoal = true }
                Spacer()
            }
        }
        .padding()
    }

    // The title and the date on the left, the calendar and goal buttons on the right
    private var header: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("Activity")
                    .font(.largeTitle.bold())
                    .accessibilityAddTraits(.isHeader)
                    #if DEBUG
                    // Testing only: a long press on the title opens the time machine
                    .onLongPressGesture {
                        showTimeMachine = true
                    }
                    #endif

                Spacer()

                GlassEffectContainer(spacing: 12) {
                    HStack(spacing: 12) {
                        NavigationLink {
                            CalendarView(activity: viewModel)
                        } label: {
                            Label("Calendar", systemImage: "calendar")
                                .labelStyle(.iconOnly)
                        }
                        Button {
                            showGoal = true
                        } label: {
                            Label("Learning Goal", systemImage: "pencil.and.outline")
                                .labelStyle(.iconOnly)
                        }
                    }
                }
                .buttonStyle(.glass)
                .buttonBorderShape(.circle)
                .controlSize(.large)
                .foregroundStyle(.primary)
            }

            Text(viewModel.now.formatted(.dateTime.weekday(.wide).day().month(.wide)))
                .font(.title3)
                .foregroundStyle(.secondary)
        }
    }

    private var freezeSection: some View {
        VStack(spacing: 8) {
            Button {
                viewModel.freezeDay()
            } label: {
                Text(viewModel.isFreezeFinished ? "Freezed for a day" : "Freeze for a day")
                    .frame(maxWidth: .infinity)
            }
            .controlSize(.large)
            // Cyan glass when it can be pressed, plain dark glass when it can't
            .buttonStyle(.glass(viewModel.canFreeze ? .regular.tint(.cyan.opacity(0.85)) : .regular))
            .buttonBorderShape(.roundedRectangle(radius: 16))
            .foregroundStyle(viewModel.canFreeze ? .white : .secondary)
            // The same width as the Log circle: 70% of the screen
            .containerRelativeFrame(.horizontal) { width, _ in width * 0.7 }
            .disabled(!viewModel.canFreeze)

            Text("\(viewModel.data.freezedCount) out of \(viewModel.data.goal.duration.maxFreezes) Freezes used")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.bottom, 40)
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
