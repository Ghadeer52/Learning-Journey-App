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
                .frame(width: 270, height: 270)
        }
        .buttonStyle(.plain)
        .glassEffect(isLogged ? .regular : .regular.tint(.orange).interactive(), in: .circle)
        .disabled(isLogged)
    }
}

#Preview("Not logged") {
    LogButtonView(isLogged: false) {}
}

#Preview("Logged") {
    LogButtonView(isLogged: true) {}
}
