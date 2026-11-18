//
//  LearnerApp.swift
//  LearningApp
//
//  Created by Ghadeer on 09/11/2026.
//

import SwiftUI

@main
struct LearnerApp: App {
    @AppStorage("hasOnboarded") private var hasOnboarded = false
    @State private var viewModel = ActivityViewModel(storage: JSONStorageService())

    var body: some Scene {
        WindowGroup {
            Group {
                if hasOnboarded {
                    ActivityView()
                } else {
                    OnboardingView()
                }
            }
            .environment(viewModel)
            .tint(.orange)
            .preferredColorScheme(.dark)
        }
    }
}
