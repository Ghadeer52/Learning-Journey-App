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
                .font(.title)
                .foregroundStyle(color)
            Text("^[\(count) Day](inflect: true)")
                .font(.title3.bold())
            Text(title)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 16)
        .glassEffect(in: .rect(cornerRadius: 28))
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    HStack {
        StreakCardView(systemImage: "flame.fill", color: .gorange, count: 4, title: "Learned")
        StreakCardView(systemImage: "snowflake", color: .cyan, count: 1, title: "Freezed")
    }
    .padding()
}
