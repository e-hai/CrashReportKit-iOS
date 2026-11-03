// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "CrashReportKit",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
        .tvOS(.v14),
        .watchOS(.v7)
    ],
    products: [
        .library(
            name: "CrashReportKit",
            targets: ["CrashReportKit"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CrashReportKit",
            dependencies: [],
            path: "Sources/CrashReportKit"
        ),
        .testTarget(
            name: "CrashReportKitTests",
            dependencies: ["CrashReportKit"],
            path: "Tests/CrashReportKitTests"
        ),
    ]
)
