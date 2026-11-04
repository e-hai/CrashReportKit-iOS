# AGENTS.md

给在 `CrashReportKit-iOS` 仓库工作的 AI / 自动化助手的项目约定。人类可读说明见 [README.md](./README.md)。

## 项目是什么

- **CrashReportKit-iOS**：Apple 平台（iOS / macOS / tvOS / watchOS）的统一崩溃上报 SDK 仓库。
- 模块构成：
  - `CrashReportKit` — 对外发布的 Swift 库（门面抽象 + 后端适配）。
  - `CrashReportKitDemo` — 演示工程 App，使用 SwiftUI 构建，已配置 `project.yml` 与 `CrashReportKitDemo.xcodeproj`。
- 当前后端：**Firebase Crashlytics（临时）**。业务代码严禁直接依赖 Firebase Crashlytics API。

## 架构约束（必须严格遵守）

```text
宿主业务 / Sample  →  CrashReport（门面）  →  CrashReporter（协议）  →  XxxCrashReporter → 厂商 SDK
```

| 允许 | 禁止 |
|:---|:---|
| 业务只依赖 `CrashReport.*` | 在业务或 Sample 里直接使用 `Crashlytics.crashlytics()` |
| 新后端置于 `Sources/CrashReportKit/Internal/` | 把厂商具体类型暴露到公共 API 签名中 |
| 通过 `CrashBackend` / `setReporter` 扩展新后端 | 为更换厂商改动业务层的调用点 |

- **公共模块**：`CrashReportKit`
- **内部目录**：`Sources/CrashReportKit/Internal/`（非公开适配器，禁止暴露给宿主）。

## 目录地图

```text
CrashReportKit-iOS/
├── Package.swift               # SPM 描述文件
├── CrashReportKit.podspec      # CocoaPods 描述文件
├── project.yml                 # xcodegen 工程描述文件
├── CrashReportKitDemo.xcodeproj# Demo Xcode 工程
├── Sources/CrashReportKit/     # SDK 源码
│   ├── CrashReport.swift       # 对外门面
│   ├── CrashReportConfig.swift # 初始化配置
│   ├── CrashBackend.swift      # 后端枚举
│   ├── CrashReporter.swift     # 契约协议
│   └── Internal/               # 厂商适配器 (Firebase / NoOp)
├── Tests/CrashReportKitTests/  # XCTest 单元测试
├── Sample/                     # 演示 SwiftUI 工程代码
├── README.md
└── AGENTS.md
```

## 改动指引

### 发布规范

- 采用 Swift Package Manager (SPM) 与 CocoaPods 双渠道发布。
- Git 发布 Tag：格式为 `1.0.0`。
- Podspec 与 Package.swift 保持平台版本与依赖对齐。

### 改 SDK 行为

- 对外能力优先加在 `CrashReport` + `CrashReporter`，再在具体适配器中补齐实现。
- 初始化参数放进 `CrashReportConfig`，必须保持默认值与二进制/源码兼容。
- Firebase 相关逻辑只在 `Internal/FirebaseCrashReporter.swift` 维护。

### 扩展新后端

1. 在 `Sources/CrashReportKit/Internal/` 新建 `XxxCrashReporter.swift : CrashReporter`。
2. 在 `CrashBackend` 增加枚举成员。
3. 在 `CrashReport.initialize` 的 `switch` 分支中实例化对应适配器。
4. 更新 README 中的架构与接入说明。
5. **绝对不要**改变业务层调用范式（业务代码永远只调用 `CrashReport.*`）。

## 验证命令

```bash
# 运行单元测试
swift test

# 构建 Package 产物
swift build

# 校验 Demo App 编译
xcodebuild -project CrashReportKitDemo.xcodeproj -scheme CrashReportKitDemo -destination 'generic/platform=iOS Simulator' build
```
