import Foundation

/// Crash reporting SDK facade for iOS / Apple platforms.
///
/// Call `CrashReport.initialize()` once during app startup (e.g. in `App.init` or
/// `application(_:didFinishLaunchingWithOptions:)`).
///
/// Business code should only depend on this type so the underlying vendor
/// (currently Firebase Crashlytics) can be swapped later without touching call sites.
///
/// Host app requirements when using `CrashBackend.firebase`:
/// - Configure Firebase via `FirebaseApp.configure()` in your app lifecycle.
/// - Include `GoogleService-Info.plist` in your application target.
/// - Link `FirebaseCrashlytics` in your application project.
public final class CrashReport: @unchecked Sendable {

    private static let shared = CrashReport()

    private let lock = NSLock()
    private var reporter: CrashReporter = NoOpCrashReporter.shared
    private var initialized: Bool = false

    private init() {}

    /// Initializes the crash reporter facade with configuration.
    /// Subsequent calls are ignored to prevent re-initialization races.
    public static func initialize(config: CrashReportConfig = CrashReportConfig()) {
        shared.lock.lock()
        defer { shared.lock.unlock() }

        if shared.initialized { return }

        shared.reporter = if !config.enabled {
            NoOpCrashReporter.shared
        } else {
            switch config.backend {
            case .firebase:
                FirebaseCrashReporter()
            }
        }

        shared.reporter.setCollectionEnabled(config.collectionEnabled)
        shared.initialized = true
    }

    /// Injects a custom `CrashReporter`. Prefer `initialize` for normal use;
    /// this is mainly for unit tests or custom backend adapters.
    public static func setReporter(_ customReporter: CrashReporter) {
        shared.lock.lock()
        defer { shared.lock.unlock() }

        shared.reporter = customReporter
        shared.initialized = true
    }

    /// Resets internal state for unit testing purposes.
    internal static func resetForTesting() {
        shared.lock.lock()
        defer { shared.lock.unlock() }

        shared.reporter = NoOpCrashReporter.shared
        shared.initialized = false
    }

    /// Returns whether the SDK has been initialized.
    public static func isInitialized() -> Bool {
        shared.lock.lock()
        defer { shared.lock.unlock() }
        return shared.initialized
    }

    /// Toggles crash data collection dynamically at runtime.
    public static func setCollectionEnabled(_ enabled: Bool) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setCollectionEnabled(enabled)
    }

    /// Associates an identifier with subsequent crash reports.
    public static func setUserId(_ userId: String?) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setUserId(userId)
    }

    /// Sets custom metadata key-value pair as String.
    public static func setCustomKey(_ key: String, value: String) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setCustomKey(key, value: value)
    }

    /// Sets custom metadata key-value pair as Bool.
    public static func setCustomKey(_ key: String, value: Bool) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setCustomKey(key, value: value)
    }

    /// Sets custom metadata key-value pair as Int.
    public static func setCustomKey(_ key: String, value: Int) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setCustomKey(key, value: value)
    }

    /// Sets custom metadata key-value pair as Int64.
    public static func setCustomKey(_ key: String, value: Int64) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setCustomKey(key, value: value)
    }

    /// Sets custom metadata key-value pair as Float.
    public static func setCustomKey(_ key: String, value: Float) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setCustomKey(key, value: value)
    }

    /// Sets custom metadata key-value pair as Double.
    public static func setCustomKey(_ key: String, value: Double) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.setCustomKey(key, value: value)
    }

    /// Appends a log message (breadcrumb) to be attached to subsequent crash reports.
    public static func log(_ message: String) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.log(message)
    }

    /// Records a non-fatal error / exception.
    public static func recordException(_ error: Error) {
        shared.lock.lock()
        let currentReporter = shared.reporter
        shared.lock.unlock()

        currentReporter.recordException(error)
    }

    /// Forces a fatal crash. Use only in debug / QA builds.
    public static func testCrash() -> Never {
        fatalError("CrashReport test crash")
    }
}
