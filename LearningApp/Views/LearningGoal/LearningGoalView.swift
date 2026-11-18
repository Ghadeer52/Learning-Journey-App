//
//  LearningGoalView.swift
//  LearningApp
//
//  Created by Ghadeer on 18/11/2026.
//

import SwiftUI

struct LearningGoalView: View {
    @Environment(ActivityViewModel.self) private var activityViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var viewModel: LearningGoalViewModel
    @State private var showAlert = false

    // True while the goal is running: changing it then starts the streak over
    let needsConfirmation: Bool

    init(goal: LearningGoal, needsConfirmation: Bool) {
        _viewModel = State(initialValue: LearningGoalViewModel(goal: goal, requiresChange: needsConfirmation))
        self.needsConfirmation = needsConfirmation
    }

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading) {
                    Text("I want to learn")
                    TextField("Topic", text: $viewModel.topic)
                    Divider()
                }

                VStack(alignment: .leading) {
                    Text("I want to learn it in a")
                    DurationPickerView(selection: $viewModel.duration)
                }

                Spacer()
            }
            .padding()
            .navigationTitle("Learning Goal")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Back", systemImage: "chevron.left") {
                        dismiss()
                    }
                    .tint(.primary)
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(role: .confirm) {
                        save()
                    }
                    .tint(.orange)
                    .disabled(!viewModel.canSave)
                }
            }
            .alert("Update goal", isPresented: $showAlert) {
                Button("Dismiss", role: .cancel) { }
                Button("Update") {
                    update()
                }
            } message: {
                Text("If you update now, your streak will start over.")
            }
        }
    }

    private func save() {
        if needsConfirmation {
            // The streak starts over, so ask first
            showAlert = true
        } else {
            // The goal is over, so there is no streak to lose
            update()
        }
    }

    private func update() {
        activityViewModel.setGoal(topic: viewModel.cleanTopic, duration: viewModel.duration)
        dismiss()
    }
}

#Preview {
    LearningGoalView(goal: ActivityViewModel.preview.data.goal, needsConfirmation: true)
        .environment(ActivityViewModel.preview)
}
