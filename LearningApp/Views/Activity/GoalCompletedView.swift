//
//  GoalCompletedView.swift
//  LearningApp
//
//  Created by Ghadeer on 18/11/2026.
//

import SwiftUI

struct GoalCompletedView: View {
    let isReached: Bool
    let setGoal: () -> Void

    var body: some View {
        ContentUnavailableView {
            Label {
                Text(isReached ? "Well done!" : "You didn't reach your goal this time")
            } icon: {
                Image(systemName: isReached ? "hands.clap.fill" : "xmark.seal")
                    .foregroundStyle(.gorange)
            }
        } description: {
            Text(isReached ? "Ready for your next goal?" : "Want to set another goal?")
        } actions: {
            Button("Set a goal", systemImage: "pencil.and.outline", action: setGoal)
                .controlSize(.large)
                .buttonStyle(.glass(.regular.tint(.gorange)))
                .foregroundStyle(.white)
        }
    }
}

#Preview("Reached") {
    GoalCompletedView(isReached: true) { }
}

#Preview("Missed") {
    GoalCompletedView(isReached: false) { }
}
