# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Culet is an iOS medical patient management app built with SwiftUI + SwiftData. Target: iOS 17+ (uses `@Observable`, SwiftData). Pure Apple ecosystem — no external dependencies.

## Build & Test

This is a standard Xcode project (no SPM package manifest). Build and test via Xcode or `xcodebuild`:

```bash
# Build
xcodebuild -project Culet.xcodeproj -scheme Culet -destination 'platform=iOS Simulator,name=iPhone 16' build

# Run all tests
xcodebuild -project Culet.xcodeproj -scheme Culet -destination 'platform=iOS Simulator,name=iPhone 16' test

# Run a single test class
xcodebuild -project Culet.xcodeproj -scheme Culet -destination 'platform=iOS Simulator,name=iPhone 16' test -only-testing:CuletTests/PatientFormattingTests
```

Tests use the modern **Swift Testing** framework (`@Test`, `@Suite`, `#expect`) — not XCTest.

There is a **CuletDraft** target for experimental/exploratory code. It is not part of the main app or tests.

## Architecture

**MVVM + service layer**, with SwiftData for persistence and `@Observable` for reactive state.

### Layer breakdown

| Layer | Path | Role |
|---|---|---|
| Models | `Culet/Models/` | SwiftData `@Model` and plain structs (`Patient`, `FullName`, `Sex`, `Reception`, `PatientsListSection`) |
| ViewModels | `Culet/ViewModels/` | `@Observable` classes; one per tab (`PatientsListTabViewModel`, `PatientFormViewModel`) |
| Views | `Culet/Views/` | SwiftUI views, organized by tab (`PatientsListTab/`, `PatientTab/`, `SettingsTab/`) |
| Services | `Culet/Services/` | Business logic and data access, split into `Core/`, `Database/`, `Communication/` |
| Helpers | `Culet/Helpers/` | Extensions, error types, shared UI components |

### Dependency injection

Services are injected via initializers with default implementations. In SwiftUI previews, `PreviewDependenciesModifier` and `PreviewContainer` supply in-memory stubs. Do not rely on singletons except `AppDatabase` (manages the SwiftData `ModelContainer`).

### App entry point

`CuletApp` instantiates top-level services (`ErrorManager`, `AppCoordinator`, `UserPreferences`, `AppSession`) as `@State` objects and injects them as environment values. `TabsView` reads `AppCoordinator.activeTab` to route between the three tabs.

### Error handling

Custom error types live in `Culet/Helpers/Errors/` (`PhoneCallError`, `PatientFormError`). `ErrorManager` (implements `ErrorManageService`) collects errors and surfaces them as an alert in `CuletApp`. ViewModels report errors through this manager rather than handling presentation themselves.

### Key patterns

- **Extensions for domain logic**: formatting, validation, and calculations are extensions on their types (`FullName+Formatting`, `Patient+Age`, `Date+TimePeriod`, `String+Mask`).
- **Use cases as objects**: `CallPatientUseCase` wraps phone-calling coordination; keeps ViewModels thin.
- **Protocol + mock for tests**: `CommunicationTests` uses `MockPhoneCaller` / `MockErrorManager` — follow the same protocol-first approach for any new testable service.
- **UI language**: The app UI is in Russian.
