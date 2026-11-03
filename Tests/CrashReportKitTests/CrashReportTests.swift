import XCTest
@testable import CrashReportKit

final class MockCrashReporter: CrashReporter, @unchecked Sendable {
    var collectionEnabled: Bool?
    var userId: String?
    var customKeys: [String: Any] = [:]
    var logs: [String] = []
    var recordedExceptions: [Error] = []

    func setCollectionEnabled(_ enabled: Bool) {
        collectionEnabled = enabled
    }

    func setUserId(_ userId: String?) {
        self.userId = userId
    }

    func setCustomKey(_ key: String, value: String) {
        customKeys[key] = value
    }

    func setCustomKey(_ key: String, value: Bool) {
        customKeys[key] = value
    }

    func setCustomKey(_ key: String, value: Int) {
        customKeys[key] = value
    }

    func setCustomKey(_ key: String, value: Int64) {
        customKeys[key] = value
    }

    func setCustomKey(_ key: String, value: Float) {
        customKeys[key] = value
    }

    func setCustomKey(_ key: String, value: Double) {
        customKeys[key] = value
    }

    func log(_ message: String) {
        logs.append(message)
    }

    func recordException(_ error: Error) {
        recordedExceptions.append(error)
    }
}

enum SampleTestError: Error {
    case generalFailure
}

final class CrashReportTests: XCTestCase {

    override func setUp() {
        super.setUp()
        CrashReport.resetForTesting()
    }

    func testInitialStateBeforeInit() {
        XCTAssertFalse(CrashReport.isInitialized())
    }

    func testInitializationWithDefaultConfig() {
        CrashReport.initialize()
        XCTAssertTrue(CrashReport.isInitialized())
    }

    func testDisabledConfigDoesNotCrash() {
        CrashReport.initialize(config: CrashReportConfig(enabled: false))
        XCTAssertTrue(CrashReport.isInitialized())
        CrashReport.log("test-message")
        CrashReport.setUserId("user123")
    }

    func testCustomReporterInjectionAndForwarding() {
        let mock = MockCrashReporter()
        CrashReport.setReporter(mock)

        XCTAssertTrue(CrashReport.isInitialized())

        CrashReport.setCollectionEnabled(false)
        XCTAssertEqual(mock.collectionEnabled, false)

        CrashReport.setUserId("test-user-id")
        XCTAssertEqual(mock.userId, "test-user-id")

        CrashReport.setCustomKey("env", value: "testing")
        XCTAssertEqual(mock.customKeys["env"] as? String, "testing")

        CrashReport.setCustomKey("flag", value: true)
        XCTAssertEqual(mock.customKeys["flag"] as? Bool, true)

        CrashReport.setCustomKey("count", value: 42)
        XCTAssertEqual(mock.customKeys["count"] as? Int, 42)

        CrashReport.setCustomKey("timestamp", value: Int64(1700000000))
        XCTAssertEqual(mock.customKeys["timestamp"] as? Int64, 1700000000)

        CrashReport.setCustomKey("score", value: Float(98.5))
        XCTAssertEqual(mock.customKeys["score"] as? Float, 98.5)

        CrashReport.setCustomKey("ratio", value: Double(3.14159))
        XCTAssertEqual(mock.customKeys["ratio"] as? Double, 3.14159)

        CrashReport.log("breadcrumb-1")
        XCTAssertEqual(mock.logs, ["breadcrumb-1"])

        CrashReport.recordException(SampleTestError.generalFailure)
        XCTAssertEqual(mock.recordedExceptions.count, 1)
    }
}
