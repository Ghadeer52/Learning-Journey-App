//
//  MonthView.swift
//  LearningApp
//
//  Created by Ghadeer on 18/11/2026.
//

import SwiftUI

struct MonthView: View {
    let month: Date
    let viewModel: CalendarViewModel

    // Seven equal columns, one for each day of the week
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        VStack(alignment: .leading) {
            Text(month.formatted(.dateTime.month(.wide).year()))
                .font(.headline)

            LazyVGrid(columns: columns) {
                ForEach(viewModel.weekdayNames, id: \.self) { name in
                    Text(name)
                        .font(.caption.bold())
                        .textCase(.uppercase)
                        .foregroundStyle(.secondary)
                }

                ForEach(Array(viewModel.days(in: month).enumerated()), id: \.offset) { _, day in
                    if let day {
                        DayCellView(
                            date: day,
                            status: viewModel.status(for: day),
                            isToday: Calendar.current.isDateInToday(day)
                        )
                    } else {
                        Color.clear
                    }
                }
            }
        }
    }
}
