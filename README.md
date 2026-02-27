<div align="center">

<!-- Badges -->
<p>
  <img src="https://img.shields.io/badge/Flutter-3.11+-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.11+-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Web-brightgreen?style=for-the-badge" alt="Platform" />
  <img src="https://img.shields.io/badge/License-MIT-yellow?style=for-the-badge" alt="License" />
</p>
<p>
  <img src="https://img.shields.io/badge/Version-1.0.0-blue?style=flat-square" alt="Version" />
  <img src="https://img.shields.io/badge/Build-Passing-success?style=flat-square" alt="Build" />
  <img src="https://img.shields.io/badge/Style-Cartoon%20Network-ff6b9d?style=flat-square" alt="Style" />
</p>

# Cartoon Notes

**A playful note-taking app with a Cartoon Network-inspired UI.**

Bold outlines, vibrant colors, bouncy animations — note-taking has never been this fun.

</div>

---

## Overview

Cartoon Notes is a lightweight note-taking application built with Flutter. The design language draws heavy inspiration from Cartoon Network's iconic visual style — thick black outlines, flat vivid colors, rounded balloon-like shapes, and elastic animations throughout the interface.

Despite its playful appearance, the app is fully functional with persistent local storage, color-coded notes, and a responsive grid layout.

## Features

| Feature | Description |
|---|---|
| **Cartoon UI** | Thick borders, flat drop shadows, balloon shapes, vibrant color palette |
| **8 Color Themes** | Each note can be assigned one of 8 distinct colors inspired by CN shows |
| **Persistent Storage** | Notes are saved locally via SharedPreferences |
| **Smooth Animations** | Elastic page transitions, scale-on-tap feedback, bouncing FAB |
| **Custom Painter BG** | Decorative wave patterns and circles drawn with CustomPainter |
| **Grid Layout** | Responsive 2-column masonry grid for note cards |
| **CRUD Operations** | Create, read, update, and delete notes with confirmation dialogs |
| **Google Fonts** | Baloo Bhai 2 — a rounded, bold typeface that matches the cartoon aesthetic |

## Screenshots

> _Add screenshots here after building the app._
>
> Recommended: Home screen (empty state), Home screen (with notes), Note editing screen, Delete confirmation dialog.

## Tech Stack

- **Framework:** Flutter 3.11+
- **Language:** Dart 3.11+
- **State Management:** setState (lightweight, no external dependency)
- **Storage:** shared_preferences
- **Typography:** google_fonts (Baloo Bhai 2)
- **Localization:** intl

## Project Structure

```
lib/
├── main.dart                  # App entry point & theme configuration
├── models/
│   └── note.dart              # Note data model with JSON serialization
├── screens/
│   ├── home_screen.dart       # Main screen — note grid, empty state, FAB
│   └── note_edit_screen.dart  # Note creation & editing with color picker
├── services/
│   └── note_storage.dart      # Local persistence layer (SharedPreferences)
├── theme/
│   └── cartoon_theme.dart     # Design tokens — colors, decorations, text styles
└── widgets/
    ├── cartoon_bg_painter.dart # CustomPainter for decorative background
    └── note_card.dart          # Animated note card widget with tap feedback
```

## Getting Started

### Prerequisites

- Flutter SDK `>=3.11.0`
- Dart SDK `>=3.11.0`
- Android Studio / VS Code with Flutter extension

### Installation

```bash
# Clone the repository
git clone https://github.com/your-username/cartoon-notes.git
cd cartoon-notes

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Build for Release

```bash
# Android APK
flutter build apk --release

# Android App Bundle (recommended for Play Store)
flutter build appbundle --release
```

Output paths:
- APK: `build/app/outputs/flutter-apk/app-release.apk`
- AAB: `build/app/outputs/bundle/release/app-release.aab`

## Color Palette

The note colors are directly inspired by Cartoon Network shows:

| Color | Hex | Inspiration |
|---|---|---|
| Yellow | `#FFE066` | Adventure Time |
| Red | `#FF6B6B` | Powerpuff Girls — Blossom |
| Blue | `#74D9FF` | Regular Show |
| Green | `#95F9A3` | Ben 10 |
| Pink | `#FF9FF3` | Powerpuff Girls — Bubbles |
| Orange | `#FFB347` | Dexter's Laboratory |
| Purple | `#C3ABFF` | Foster's Home for Imaginary Friends |
| Teal | `#6BFFDC` | Courage the Cowardly Dog |

## Configuration

| Setting | File | Line |
|---|---|---|
| Package name | `android/app/build.gradle.kts` | `applicationId` |
| App display name | `android/app/src/main/AndroidManifest.xml` | `android:label` |
| Version | `pubspec.yaml` | `version` |
| Signing config | `android/app/build.gradle.kts` | `signingConfig` |

## Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

<div align="center">
  <sub>Built with Flutter & a love for cartoons.</sub>
</div>
