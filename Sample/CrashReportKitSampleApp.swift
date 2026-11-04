import SwiftUI
import CrashReportKit

#if canImport(FirebaseCore)
import FirebaseCore
#endif

@main
struct CrashReportKitSampleApp: App {

    init() {
        // Optional Firebase configuration if GoogleService-Info.plist is configured
        #if canImport(FirebaseCore)
        if Bundle.main.path(forResource: "GoogleService-Info", ofType: "plist") != nil {
            FirebaseApp.configure()
        }
        #endif

        // Initialize CrashReportKit facade once on app launch
        CrashReport.initialize(
            config: CrashReportConfig(
                enabled: true,
                collectionEnabled: true,
                backend: .firebase
            )
        )

        // Set global user context and initial metadata
        CrashReport.setUserId("sample-ios-user")
        CrashReport.setCustomKey("app_flavor", value: "sample")
        CrashReport.setCustomKey("platform", value: "iOS")
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
