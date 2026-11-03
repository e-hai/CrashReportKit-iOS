import Foundation

/// Configuration for `CrashReport.initialize`.
///
/// - Parameters:
///   - enabled: Master switch. When false, all calls become no-ops.
///   - collectionEnabled: Whether the backend may upload crash data.
///   - backend: Reporting implementation. Defaults to `.firebase`.
public struct CrashReportConfig: Sendable {
    public let enabled: Bool
    public let collectionEnabled: Bool
    public let backend: CrashBackend

    public init(
        enabled: Bool = true,
        collectionEnabled: Bool = true,
        backend: CrashBackend = .firebase
    ) {
        self.enabled = enabled
        self.collectionEnabled = collectionEnabled
        self.backend = backend
    }
}
