# AGENTS.md

给在 CrashReportKit-iOS 仓库工作的 AI / 自动化助手的项目约定。说明见 [README.md](./README.md)。

## 项目是什么

- **CrashReportKit-iOS**：Apple 平台崩溃上报 SDK (Swift)。
- 当前后端：**Firebase Crashlytics（临时）**。业务代码不得直接依赖 Firebase Crashlytics API。

## 架构约束（必须遵守）

```text
业务 / Sample  →  CrashReport（门面）  →  CrashReporter（协议）  →  XxxCrashReporter → 厂商 SDK
```

| 允许 | 禁止 |
|------|------|
| 业务只调用 `CrashReport.*` | 在业务或 Sample 里直接使用 `Crashlytics.crashlytics()` |
| 新后端放在 `Sources/CrashReportKit/Internal/` | 把厂商类型暴露到公共 API 签名里 |
| 通过 `CrashBackend` / `setReporter` 扩展 | 为换厂商去改动业务层的调用点 |

- 公共模块：`CrashReportKit`
- 内部文件约定：`Sources/CrashReportKit/Internal/`（非公开适配器，不得暴露给宿主）。

## 目录地图

```text
CrashReportKit/
├── Package.swift               # SPM 描述文件
├── CrashReportKit.podspec      # CocoaPods 描述文件
├── Sources/CrashReportKit/     # SDK 源码
│   ├── CrashReport.swift       # 对外门面
│   ├── CrashReportConfig.swift # 初始化配置
│   ├── CrashBackend.swift      # 后端枚举
│   ├── CrashReporter.swift     # 契约协议
│   └── Internal/               # 厂商适配器 (Firebase / NoOp)
├── Tests/CrashReportKitTests/  # XCTest 单元测试
├── Sample/                     # 演示 SwiftUI 工程
├── README.md
└── AGENTS.md
```

## 改动指引

### 改 SDK 行为

- 对外能力优先加在 `CrashReport` + `CrashReporter`，再在各适配器实现。
- 初始化参数放进 `CrashReportConfig`，保持默认值与二进制/源码兼容。
- Firebase 相关只动 `Internal/FirebaseCrashReporter.swift`。

### 换 / 加上报厂商

1. 新增 `Internal/XxxCrashReporter.swift : CrashReporter`。
2. 在 `CrashBackend` 增加枚举成员。
3. 在 `CrashReport.initialize` 的 `switch` 中创建实例。
4. 更新 README 架构说明与宿主配置要求。
5. **不要**改业务调用风格（仍只展示 `CrashReport.*`）。

### 改 Sample

- 示例统一采用 SwiftUI，业务调用只调用 `CrashReport.*`。
- `Sample/.../GoogleService-Info.plist` 为占位；文档需写明真实上报需替换。

## 验证

```bash
swift test
swift build
```

## 不要做的事

- 不要把 Crashlytics / 其他厂商 SDK 写成业务层直接依赖。
- 不要为了「演示方便」删除 `CrashReporter` 抽象、让门面直接调用 Firebase。
- 不提交密钥、真实 `GoogleService-Info.plist`。
- 不跑 `git push`，除非用户明确要求。
