//
//  DayCellView.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import SwiftUI

struct DayCellView: View {
    let date: Date
    let status: DayStatus?
    let isToday: Bool

    @ScaledMetric private var size = 42.0

    var body: some View {
        Text(date.formatted(.dateTime.day()))
            .font(.title3)
            .frame(width: size, height: size)
            .foregroundStyle(textColor)
            .background(backgroundColor, in: .circle)
            .accessibilityLabel(date.formatted(.dateTime.weekday(.wide).day().month(.wide)))
            .accessibilityValue(statusText)
    }

    private var textColor: Color {
        switch status {
        case .learned: return .orange
        case .frozen: return .cyan
        case nil: return isToday ? .white : .primary
        }
    }

    private var backgroundColor: Color {
        switch status {
        case .learned: return .orange.opacity(0.2)
        case .frozen: return .cyan.opacity(0.2)
        case nil: return isToday ? .orange : .clear
        }
    }

    // Read out by VoiceOver
    private var statusText: String {
        switch status {
        case .learned: return "Learned"
        case .frozen: return "Freezed"
        case nil: return "Not logged"
        }
    }
}

#Preview {
    HStack {
        DayCellView(date: .now, status: .learned, isToday: false)
        DayCellView(date: .now, status: .frozen, isToday: false)
        DayCellView(date: .now, status: nil, isToday: true)
        DayCellView(date: .now, status: nil, isToday: false)
    }
}
