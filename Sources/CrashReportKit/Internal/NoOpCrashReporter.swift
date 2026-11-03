import Foundation

/// Fallback crash reporter used when reporting is disabled or before initialization.
final class NoOpCrashReporter: CrashReporter, @unchecked Sendable {
    static let shared = NoOpCrashReporter()

    private init() {}

    func setCollectionEnabled(_ enabled: Bool) {}
    func setUserId(_ userId: String?) {}
    func setCustomKey(_ key: String, value: String) {}
    func setCustomKey(_ key: String, value: Bool) {}
    func setCustomKey(_ key: String, value: Int) {}
    func setCustomKey(_ key: String, value: Int64) {}
    func setCustomKey(_ key: String, value: Float) {}
    func setCustomKey(_ key: String, value: Double) {}
    func log(_ message: String) {}
    func recordException(_ error: Error) {}
}
