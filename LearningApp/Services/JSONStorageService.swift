//
//  JSONStorageService.swift
//  LearningApp
//
//  Created by Ghadeer on 15/11/2026.
//

import Foundation

/// Saves the learner's data as a JSON file in the Documents folder.
struct JSONStorageService: ActivityStorage {
    private let fileURL: URL

    init(fileName: String = "activity.json") {
        fileURL = URL.documentsDirectory.appending(path: fileName)
    }

    func load() -> ActivityData? {
        // No file yet means this is the first launch.
        guard FileManager.default.fileExists(atPath: fileURL.path(percentEncoded: false)) else {
            return nil
        }

        do {
            let data = try Data(contentsOf: fileURL)
            return try JSONDecoder().decode(ActivityData.self, from: data)
        } catch {
            print("Could not load data: \(error)")
            return nil
        }
    }

    func save(_ activityData: ActivityData) {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // easier to read when you open the file
            let data = try encoder.encode(activityData)
            try data.write(to: fileURL, options: .atomic)
        } catch {
            print("Could not save data: \(error)")
        }
    }
}
