# Learning Journey

A small iOS app that helps you keep a daily learning streak. You choose a topic and how long you want to learn it (a week, a month or a year). Each day you either log the day as **learned**, or use a **freeze** to protect your streak.

Built with SwiftUI for the Apple Developer Academy challenge.

## How it works

- On the first launch you set a topic and a duration.
- Each day you can tap **Log as Learned** or **Freeze for a day**.
- A freeze keeps the streak alive but does not add a learned day.
  - Freezes per goal: 2 for a week, 8 for a month, 96 for a year.
  - If you freeze and then log the same day, the freeze is given back.
- Both buttons turn off after you log a day, and come back at 12 AM.
- The streak starts over when more than 32 hours pass with nothing logged. The 32 hours start at 12 AM after your last logged day.
- Changing the goal starts the streak over. The days you already logged stay on the calendar.
- When every day of the goal is logged you see "Well done!". If the goal ends with empty days you see "You didn't reach your goal this time".
- The calendar shows every past day. Orange is learned, cyan is freezed, and today is highlighted.

## Structure (MVVM)

| Folder | What is inside |
|---|---|
| `Models` | The data: `Duration`, `DayStatus`, `GoalStatus`, `LearningGoal`, `ActivityData` |
| `Services` | `StreakManager` (all the rules), and the storage: a protocol, a JSON file version and a mock version |
| `ViewModels` | `ActivityViewModel`, `OnboardingViewModel`, `LearningGoalViewModel`, `CalendarViewModel` |
| `Views` | The screens, and small views used inside them |
| `Extensions` | `Date+Extensions`, a helper that turns a date into a "yyyy-MM-dd" key |

- Models are structs and enums. View models are classes marked `@Observable`.
- The main view model is created once in `LearnerApp` and shared with `.environment`.
- Data is saved as JSON in the Documents folder. The view model only knows the `ActivityStorage` protocol, so previews and tests can use a mock.
- `StreakManager` never reads the clock. The current date is passed in, so the rules are easy to test.
- Logged days are saved in a dictionary with "yyyy-MM-dd" keys. "Logged today" is calculated, never saved.

## What it uses

- SwiftUI, `@Observable`, `@AppStorage`, `@Environment`
- Liquid Glass (`glassEffect`, `glass` and `glassProminent` button styles, `GlassEffectContainer`)
- Apple's own components: `NavigationStack`, toolbar, sheet, alert, `ContentUnavailableView`
- `Calendar` for all date math
- Swift Testing for the unit tests

## Tests

`LearningAppTests` checks the rules in `StreakManager`: the 32-hour reset, the midnight rule, the freeze limits, and whether a goal is reached or missed. Run them with Cmd+U.

## Choices to know about

- The app is always in dark mode, to match the design. Apple suggests following the user's setting.
- The "Start Learning" button stays off until a topic is typed.
- The screen titles use Apple's standard navigation title, so the header is slightly different from the design.

## Run it

Open `LearningApp.xcodeproj` in Xcode, choose an iPhone simulator running iOS 27 or later, and press Run.
