//
//  CalendarView.swift
//  LearningApp
//
//  Created by Ghadeer on 18/11/2026.
//

import SwiftUI

struct CalendarView: View {
    @State private var viewModel: CalendarViewModel

    init(activity: ActivityViewModel) {
        _viewModel = State(initialValue: CalendarViewModel(activity: activity))
    }

    var body: some View {
        ScrollView {
            // Lazy: a month is only built when it is about to appear
            LazyVStack(alignment: .leading, spacing: 16) {
                ForEach(viewModel.months, id: \.self) { month in
                    MonthView(month: month, viewModel: viewModel)

                    // A thin line between the months
                    if month != viewModel.months.last {
                        Divider()
                    }
                }
            }
            .padding()
        }
        // Start at the bottom, where the current month is
        .defaultScrollAnchor(.bottom)
        .navigationTitle("Activities")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        CalendarView(activity: ActivityViewModel.previewLongHistory)
    }
}
