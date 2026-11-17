//
//  DurationPickerView.swift
//  LearningApp
//
//  Created by Ghadeer on 17/11/2026.
//

import SwiftUI

extension Duration {
    // The words on the buttons
    var title: String {
        switch self {
        case .week:
            return "Week"
        case .month:
            return "Month"
        case .year:
            return "Year"
        }
    }
}

struct DurationPickerView: View {
    @Binding var selection: Duration

    var body: some View {
        GlassEffectContainer {
            // Side by side when there is room, stacked when the text is very large
            ViewThatFits {
                HStack {
                    buttons
                }
                VStack(alignment: .leading) {
                    buttons
                }
            }
        }
    }

    private var buttons: some View {
        ForEach(Duration.allCases, id: \.self) { duration in
            Button(duration.title) {
                selection = duration
            }
            .buttonStyle(.glass(selection == duration ? .regular.tint(.orange) : .regular))
            .foregroundStyle(selection == duration ? .white : .secondary)
            .controlSize(.large)
            .accessibilityAddTraits(selection == duration ? .isSelected : [])
        }
    }
}

#Preview {
    @Previewable @State var duration = Duration.week
    DurationPickerView(selection: $duration)
}
