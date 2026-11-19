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
        .glassEffect(isLogged ? .regular : .regular.tint(.gorange.opacity(0.85)).interactive(), in: .circle)
        .disabled(isLogged)
    }
}

#Preview("Not logged") {
    LogButtonView(isLogged: false) {}
}

#Preview("Logged") {
    LogButtonView(isLogged: true) {}
}
