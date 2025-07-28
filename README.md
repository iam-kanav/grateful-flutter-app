# Grateful ✨ - A Daily Gratitude Journal

Grateful is a beautifully designed, minimalist Flutter application built to help you cultivate a positive mindset by journaling daily moments of gratitude. It's more than just a journal; it's a companion that provides you with a dose of motivation sourced from your own positive memories and a curated list of uplifting quotes.

This project was built following a comprehensive project-based roadmap, focusing on clean architecture, beautiful UI/UX, and modern Flutter best practices.

## 📸 Screenshots

| Light Mode | Dark Mode |
| :---: | :---: |
| <img src="https://cdn.imgchest.com/files/4jdcv6qkrx4.jpg" width="250"> | <img src="https://cdn.imgchest.com/files/yxkczq9bmk7.jpg" width="250"> |
| <img src="https://cdn.imgchest.com/files/yd5cemdqxq4.jpg" width="250"> | <img src="https://cdn.imgchest.com/files/4nec8l6gjp4.jpg" width="250"> |
| <img src="https://cdn.imgchest.com/files/yrgcn9erw84.jpg" width="250"> | <img src="https://cdn.imgchest.com/files/7kzcaxmdor7.jpg" width="250"> |


## 🌟 Features

- **✒️ Elegant Journaling:** A clean, intuitive interface to add, review, and delete your daily gratitude entries.
- **🎨 Beautiful & Themed UI:** A custom, serene theme with full support for both **Light and Dark Modes**.
- **💡 Dynamic Motivation:** A dedicated screen that provides motivational quotes, dynamically pulling from either your own past journal entries or a curated list of inspirational messages.
- **🔄 Smooth Animations:** Fluid page transitions and subtle animations that create a delightful user experience.
- **💾 100% Offline First:** All your journal entries are stored securely on your device using **Hive**, ensuring your data is always available and private.
- **🔔 Smart Notifications:**
    - **Scheduled Reminders:** Users can set a specific time to receive a daily notification to write in their journal.
    - **Spontaneous Motivation:** Opt-in to receive random motivational quotes throughout the day to keep your spirits high.
- **👆 Swipe to Delete:** Easily manage your journal with an intuitive swipe-to-delete gesture.
- **✅ Clean Architecture:** Built with a scalable architecture using the **Provider** pattern for state management, separating UI from business logic.

## 🛠️ Tech Stack & Key Packages

- **Framework:** [Flutter](https://flutter.dev/)
- **Language:** [Dart](https://dart.dev/)
- **Architecture:** MVVM-like pattern with Provider
- **State Management:** [provider](https://pub.dev/packages/provider)
- **Local Database:** [hive](https://pub.dev/packages/hive) & [hive_flutter](https://pub.dev/packages/hive_flutter)
- **Notifications:** [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- **Background Tasks:** [workmanager](https://pub.dev/packages/workmanager)
- **Shared Preferences:** [shared_preferences](https://pub.dev/packages/shared_preferences) for settings
- **Typography:** [google_fonts](https://pub.dev/packages/google_fonts) for beautiful, custom fonts.
- **Utilities:** [intl](https://pub.dev/packages/intl) for date formatting.

## 🚀 Getting Started

To run this project locally, follow these steps:

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/your-username/grateful-flutter-app.git
    cd grateful-flutter-app
    ```
2.  **Install dependencies:**
    ```bash
    flutter pub get
    ```
3.  **Generate Hive TypeAdapters:**
    The `GratitudeEntry` model uses Hive for local storage, which requires a generated adapter file. Run the following command to generate it:
    ```bash
    flutter packages pub run build_runner build --delete-conflicting-outputs
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```
    *(Note: For notification features to work correctly, running on a real physical device is highly recommended.)*

## 💡 What I Learned

Building "Grateful" was a journey from foundational concepts to advanced features. Key learning points include:
- Designing a pixel-perfect, theme-aware UI from scratch.
- Implementing a robust state management solution with `Provider`.
- Mastering local persistence with `Hive`, including models and type adapters.
- Integrating complex mobile features like scheduled and background notifications.
- Architecting a multi-screen application with a clean, scalable folder structure.
- Setting up and using Git & GitHub for version control.
