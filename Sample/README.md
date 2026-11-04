# CrashReportKit iOS Sample

演示 App 位于 `Sample/CrashReportKitSample`，使用 SwiftUI 构建。

## 功能演示

- **初始化**：在 App 启动时调用 `CrashReport.initialize(config:)`，配置采集开关与后端类型。
- **用户标识与键值**：演示 `CrashReport.setUserId(...)` 与 `CrashReport.setCustomKey(...)`。
- **面包屑日志**：演示 `CrashReport.log(...)` 记录页面流转与用户操作轨迹。
- **非致命异常**：演示 `CrashReport.recordException(...)` 捕获业务抛出的 `Error`。
- **致命崩溃模拟**：演示 `CrashReport.testCrash()` 触发 `fatalError` 进行崩溃堆栈采集验证。

## 快速打开与运行 Demo

### 方式 1：直接打开 Xcode 工程（推荐）
在终端中进入目录并打开：
```bash
cd /Users/a/Develop/project/ios/CrashReportKit-iOS
open CrashReportKitDemo.xcodeproj
```
或者在 Finder 中双击 `CrashReportKitDemo.xcodeproj`。

1. Xcode 顶部 Scheme 选择 **`CrashReportKitDemo`**。
2. 目标运行设备选择任意 **iOS Simulator**（如 iPhone 16 / 15）。
3. 按快捷键 **`Cmd + R`** 或点击左上角播放按钮即可编译并启动 Demo App。

### 方式 2：重新生成工程（如果修改了 project.yml）
本项目通过 `xcodegen` 管理项目配置，如果更新了 `project.yml`，执行以下命令即可重新生成：
```bash
xcodegen generate
```

## 真实 Firebase 控制台上报（可选）
默认情况下无需配置 Firebase 即可本地测试所有按钮和逻辑（走 NoOp / 本地安全兜底）。
若需上报至真实 Firebase 控制台：
1. 在 Firebase Console 创建 iOS 应用，Bundle ID 为 `com.kit.crashreport.demo`。
2. 下载 `GoogleService-Info.plist` 拖入 `Sample/` 目录下。
3. 在 Target 的 Build Phases 添加 Firebase Crashlytics dSYM 脚本。
