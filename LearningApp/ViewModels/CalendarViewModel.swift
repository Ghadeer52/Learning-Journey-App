//
//  CalendarViewModel.swift
//  MyApp
//
//  Created by Ghadeer on 09/11/2026.
//

import SwiftUI
import Observation

@MainActor
@Observable
final class CalendarViewModel {
    var months: [Date] = []

    func generateMonths() {
        // TODO: Fill `months` with the start of each month covered by the learning goal.
    }

    func days(in month: Date) -> [Date?] {
        // TODO: Return every day of `month`, with leading nil values to align the first weekday.
        return []
    }

    func color(for date: Date) -> Color {
        // TODO: Return orange for learned days, cyan for freezed days, and a highlight for today. The calendar is view-only.
        return .clear
    }
}
