//
//  OnboardingView.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import SwiftUI

struct OnboardingView: View {
    @Environment(ActivityViewModel.self) private var activityViewModel
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    @State private var viewModel = OnboardingViewModel()

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Image(systemName: "flame.fill")
                .font(.largeTitle)
                .imageScale(.large)
                .foregroundStyle(.gorange)
                .frame(maxWidth: .infinity)
                .accessibilityHidden(true)

            VStack(alignment: .leading) {
                Text("Hello **Learner**")
                    .font(.largeTitle)
                Text("This app will help you learn everyday!")
                    .foregroundStyle(.secondary)
            }
            .padding(.top, 60)

            VStack(alignment: .leading) {
                Text("I want to learn")
                TextField("Topic", text: $viewModel.topic, prompt: Text("Swift"))
                Divider()
            }

            VStack(alignment: .leading) {
                Text("I want to learn it in a ")
                DurationPickerView(selection: $viewModel.duration)
            }

            Spacer()

            VStack(spacing: 14) {
                Button {
                    activityViewModel.setGoal(topic: viewModel.cleanTopic, duration: viewModel.duration)
                    hasOnboarded = true
                } label: {
                    Text("Start Learning")
                }
                .controlSize(.large)
                // Orange glass when it can be pressed, plain dark glass when it can't
                .buttonStyle(.glass(viewModel.canStart ? .regular.tint(.gorange) : .regular))
                .foregroundStyle(viewModel.canStart ? .white : .secondary)
                .disabled(!viewModel.canStart)

                Text("You can edit your desire later")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
    }
}

#Preview {
    OnboardingView()
        .environment(ActivityViewModel(storage: MockStorageService()))
}
