import Foundation

/// Stores activity data as a JSON file in the Documents folder.
struct JSONStorageService: ActivityStorage {
    func save(_ data: ActivityData) {
        // TODO: Encode `data` as JSON and write it to a file in the Documents folder.
    }

    func load() -> ActivityData? {
        // TODO: Read the JSON file from the Documents folder and decode it. Return nil if missing or invalid.
        return nil
    }
}
