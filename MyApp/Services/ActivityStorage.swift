import Foundation

/// Abstraction over where activity data is stored.
protocol ActivityStorage {
    func save(_ data: ActivityData)
    func load() -> ActivityData?
}
