//
//  LogButtonView.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import SwiftUI

struct LogButtonView: View {
    let isLogged: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(isLogged ? "Logged as Learned" : "Log as Learned")
                .font(.title2.bold())
                .multilineTextAlignment(.center)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .buttonStyle(.plain)
        .glassEffect(isLogged ? .regular : .regular.tint(.orange).interactive(), in: .circle)
        .disabled(isLogged)
        .aspectRatio(1, contentMode: .fit)
        // 70% of the screen width, so it looks the same on every iPhone
        .containerRelativeFrame(.horizontal) { width, _ in width * 0.7 }
    }
}

#Preview("Not logged") {
    LogButtonView(isLogged: false) {}
}

#Preview("Logged") {
    LogButtonView(isLogged: true) {}
}
