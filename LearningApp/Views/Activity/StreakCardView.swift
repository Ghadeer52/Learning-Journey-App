//
//  StreakCardView.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import SwiftUI

struct StreakCardView: View {
    let systemImage: String
    let color: Color
    let count: Int
    let title: String

    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: systemImage)
                .font(.body)
                .foregroundStyle(color)
            Text("^[\(count) Day](inflect: true)")
                .font(.headline)
            Text(title)
                .font(.caption)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .glassEffect(in: .rect(cornerRadius: 20))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    HStack {
        StreakCardView(systemImage: "flame.fill", color: .orange, count: 4, title: "Learned")
        StreakCardView(systemImage: "snowflake", color: .cyan, count: 1, title: "Freezed")
    }
    .padding()
}
