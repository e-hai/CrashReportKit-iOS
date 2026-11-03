# CrashReportKit iOS Sample

演示 App 位于 `Sample/CrashReportKitSample`，使用 SwiftUI 构建。

## 功能演示

- **初始化**：在 App 启动时调用 `CrashReport.initialize(config:)`，配置采集开关与后端类型。
- **用户标识与键值**：演示 `CrashReport.setUserId(...)` 与 `CrashReport.setCustomKey(...)`。
- **面包屑日志**：演示 `CrashReport.log(...)` 记录页面流转与用户操作轨迹。
- **非致命异常**：演示 `CrashReport.recordException(...)` 捕获业务抛出的 `Error`。
- **致命崩溃模拟**：演示 `CrashReport.testCrash()` 触发 `fatalError` 进行崩溃堆栈采集验证。

## 接入与运行说明

1. 在 Xcode 中打开宿主工程或将 `Package.swift` 作为本地包引入。
2. 若需上报至真实的 Firebase 控制台：
   - 在 Firebase 控制台创建 iOS 应用，Bundle ID 设为 `com.kit.crashreport.sample`。
   - 下载 `GoogleService-Info.plist` 并替换 `Sample/CrashReportKitSample/Resources/GoogleService-Info.plist`。
   - 在 Xcode 构建目标中添加 `FirebaseCrashlytics` 依赖与 Run Script（dSYM 上传脚本）。
