import Foundation

/// Backend contract for crash reporting. Host apps normally use `CrashReport`;
/// implement this only when plugging in a custom reporter.
public protocol CrashReporter: AnyObject, Sendable {
    func setCollectionEnabled(_ enabled: Bool)
    func setUserId(_ userId: String?)
    func setCustomKey(_ key: String, value: String)
    func setCustomKey(_ key: String, value: Bool)
    func setCustomKey(_ key: String, value: Int)
    func setCustomKey(_ key: String, value: Int64)
    func setCustomKey(_ key: String, value: Float)
    func setCustomKey(_ key: String, value: Double)
    func log(_ message: String)
    func recordException(_ error: Error)
}
