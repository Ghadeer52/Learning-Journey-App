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
                    // Temporary. The Activity page replaces this in Step 10.
                    Button("Reset onboarding") {
                        hasOnboarded = false
                    }
                } else {
                    // Temporary. The onboarding page replaces this in Step 8.
                    Button("Start Learning") {
                        hasOnboarded = true
                    }
                }
            }
            .environment(viewModel)
        }
    }
}
