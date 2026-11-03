import Foundation

#if canImport(FirebaseCrashlytics)
import FirebaseCrashlytics
#endif

/// Temporary Firebase Crashlytics adapter. Replace by swapping `CrashBackend`
/// when another vendor is ready.
final class FirebaseCrashReporter: CrashReporter, @unchecked Sendable {

    init() {}

    func setCollectionEnabled(_ enabled: Bool) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setCrashlyticsCollectionEnabled(enabled)
        #endif
    }

    func setUserId(_ userId: String?) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setUserID(userId ?? "")
        #endif
    }

    func setCustomKey(_ key: String, value: String) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
        #endif
    }

    func setCustomKey(_ key: String, value: Bool) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
        #endif
    }

    func setCustomKey(_ key: String, value: Int) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setCustomValue(value, forKey: key)
        #endif
    }

    func setCustomKey(_ key: String, value: Int64) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setCustomValue(NSNumber(value: value), forKey: key)
        #endif
    }

    func setCustomKey(_ key: String, value: Float) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setCustomValue(NSNumber(value: value), forKey: key)
        #endif
    }

    func setCustomKey(_ key: String, value: Double) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().setCustomValue(NSNumber(value: value), forKey: key)
        #endif
    }

    func log(_ message: String) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().log(message)
        #endif
    }

    func recordException(_ error: Error) {
        #if canImport(FirebaseCrashlytics)
        Crashlytics.crashlytics().record(error: error)
        #endif
    }
}
