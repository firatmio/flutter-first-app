# v1.0.0 — Initial Release

**Release Date:** 27 February 2026

---

## What's New

First public release of Cartoon Notes — a lightweight note-taking app with a Cartoon Network-inspired user interface.

### Core Features

- **Create, edit, and delete notes** with full CRUD functionality
- **8 vibrant color themes** for organizing notes visually — each inspired by a classic Cartoon Network show
- **Persistent local storage** via SharedPreferences — notes survive app restarts
- **2-column grid layout** on the home screen for quick overview of all notes

### Design & UI

- Cartoon Network visual language: thick black outlines (3.5px borders), flat offset shadows, rounded balloon shapes
- Custom background decorations using `CustomPainter` — wave patterns and floating circles
- Colorful gradient divider strip (pink → blue → yellow → purple) under the header
- Typography powered by Google Fonts (Baloo Bhai 2) — rounded, bold, and playful
- Empty state screen with clear call-to-action

### Animations

- **Bouncing FAB** — the add button pulses continuously with an elastic animation
- **Scale-on-tap** — note cards shrink slightly when pressed for tactile feedback
- **Elastic page transitions** — `ScaleTransition` with `elasticOut` curve when navigating between screens
- **Staggered grid entrance** — note cards animate in with a cascading scale effect
- **Fade-in** on the note editing screen

### Note Editing

- Inline title and content editing with a clean, distraction-free interface
- Horizontal color picker with animated selection indicator
- Instant save — tap the save button and return to the home screen

### Dialogs

- Custom cartoon-style confirmation dialog for delete actions
- Styled cancel and confirm buttons matching the overall theme

---

## Technical Details

| | |
|---|---|
| **Flutter** | 3.11+ |
| **Dart** | 3.11+ |
| **Min Android SDK** | Flutter default |
| **Target Android SDK** | Flutter default |
| **Package** | `com.quacomes.cartoonnotes` |

### Dependencies

| Package | Version | Purpose |
|---|---|---|
| google_fonts | ^6.2.1 | Baloo Bhai 2 typeface |
| shared_preferences | ^2.3.4 | Local note persistence |
| intl | ^0.20.2 | Date/time formatting |

---

## Installation

Download the APK from the assets below and install it on your Android device.

> You may need to enable "Install from unknown sources" in your device settings.

---

## Known Limitations

- No cloud sync — notes are stored locally on the device only
- No search functionality yet
- No note pinning or sorting options
- No image or file attachments
- Single-device only — no cross-device sync

---

## What's Next (Planned)

- Search and filter notes
- Pin important notes to the top
- Dark mode with a cartoon twist
- Note categories and tags
- Cloud backup and sync
- Custom app icon matching the cartoon theme
- Widget for home screen quick access

---

**Full Changelog:** This is the initial release — everything is new.
