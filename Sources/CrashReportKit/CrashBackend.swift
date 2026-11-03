import Foundation

/// Crash reporting backend. Swap implementations without changing call sites.
/// Currently only `firebase` is wired; other backends can be added later.
public enum CrashBackend: String, Sendable, CaseIterable {
    case firebase
}
