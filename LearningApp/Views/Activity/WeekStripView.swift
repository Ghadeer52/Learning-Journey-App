//
//  WeekStripView.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import SwiftUI

struct WeekStripView: View {
    @Environment(ActivityViewModel.self) private var viewModel

    var body: some View {
        HStack {
            ForEach(viewModel.weekDays, id: \.self) { day in
                VStack {
                    Text(day.formatted(.dateTime.weekday(.narrow)))
                        .font(.caption.bold())
                        .accessibilityHidden(true)
                    DayCellView(
                        date: day,
                        status: viewModel.status(for: day),
                        isToday: Calendar.current.isDateInToday(day)
                    )
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    WeekStripView()
        .environment(ActivityViewModel.preview)
}
