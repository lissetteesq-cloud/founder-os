# Founder OS

Founder OS is a mobile-first private operating system for a solo founder learning how to build, launch, distribute, secure, and monetize products with less confusion and more structure.

This v1 is local-first, seeded with usable content, and built as a Flutter app so it can evolve toward iPhone deployment later.

## What is included

- Two tracks: `App / SaaS` and `Digital Product`
- Stage tracker with 11 stages
- Seeded learning modules with lessons, checklists, resources, notes, and AI prompt placeholders
- Daily execution screen
- Weekly review screen
- Glossary
- Decision frameworks
- Local persistence for progress, notes, journal, weekly review, and active track/stage

## Run locally

```bash
flutter pub get
flutter run
```

Common targets:

```bash
flutter run -d chrome
flutter run -d macos
flutter run -d ios
```

## Verification completed

- `flutter analyze`
- `flutter test`

## iPhone / iOS note

The project was moved to a clean standalone path:

`/Users/lissetteeusebio/founder_os`

That resolved the Xcode packaging issue caused by the earlier synced `Documents` location.

Current iOS status:

- `flutter build ios --simulator --no-codesign` passes

For personal use on your own iPhone, you do not need App Store submission. The usual path is:

- Open `ios/Runner.xcworkspace` in Xcode
- Connect your iPhone
- Set your Apple ID team in Signing
- Run the app directly to your device

## Edit the seeded content

Main content lives here:

- `lib/data/seed_content.dart`

This file contains:

- Stages
- Modules
- Lessons
- Checklists
- Resources
- AI prompts
- Glossary
- Decision frameworks

## Important files

- `lib/main.dart`: app shell and all primary screens
- `lib/state/founder_os_controller.dart`: local state and persistence
- `lib/models/founder_models.dart`: content models
- `lib/theme/app_theme.dart`: visual system based on the Stitch handoff
- `lib/data/seed_content.dart`: editable seed content

## Design decisions

- Flutter was chosen because you explicitly want this to work on iPhone and it keeps a future native deployment path open.
- SharedPreferences was used for v1 persistence because it is fast, local, and sufficient for notes, progress, and review data without adding backend complexity.
- The UI follows the Stitch handoff closely: dark tactical surfaces, 4px radii, dense cards, and a calm operator-style cockpit.
- The app stays intentionally local-first, private, and single-user for now.

## Suggested v2 directions

Not built in this version:

- Real AI integration for the module prompt assistant
- Richer analytics and experiment history
- Content import/export
- Cloud sync and backup
- Push reminders or scheduled execution prompts
- Track-specific deeper branching content
