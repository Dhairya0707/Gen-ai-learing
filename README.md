# Gem Study

## Overview
Gem Study is a Flutter-based learning platform that leverages Firebase for authentication and data storage, and the Google Generative AI API (`gemini-1.5-flash-latest`) to generate personalized learning plans and quizzes. Users can register, log in, create custom courses, and view AI-generated study content and quizzes in Markdown format.

## Features
- **User Authentication**: Register and log in using Firebase Authentication with email and password.
- **Course Creation**: Add custom courses with a name, specific focus, and difficulty level (Beginner, Intermediate, Advanced).
- **AI-Generated Content**: Generate detailed learning plans and quizzes using the Google Generative AI API.
- **Course Management**: View, navigate, and delete courses stored in Firebase Firestore.
- **Responsive UI**: Clean interface with a consistent design, supporting navigation via app bars, drawers, and floating action buttons.
- **Markdown Display**: Render AI-generated learning plans and quizzes using the `markdown_widget` package.
- **Personalized Learning**: Tailored study content based on user inputs for course name, focus, and difficulty.

## Prerequisites
- **Flutter**: Version 3.0.0 or higher (with web support enabled for web deployment).
- **Dart**: Version compatible with the Flutter version used.
- **Firebase Project**: Set up a Firebase project with Authentication (Email/Password) and Firestore enabled.
- **Google Generative AI API Key**: Obtain an API key from [Google Cloud](https://cloud.google.com/) for the `google_generative_ai` package.

## Installation
1. **Clone the Repository**:
   ```bash
   git clone <repository-url>
   cd gem-study
   ```

2. **Install Dependencies**:
   Run the following command to install required packages:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Set up a Firebase project and enable Authentication (Email/Password) and Firestore.
   - Update `lib/firebase_options.dart` with your Firebase configuration (already provided for web and Android).
   - Initialize Firebase in your app by ensuring `Firebase.initializeApp()` is called in `main.dart`.

4. **Set Up Google Generative AI API Key**:
   - Replace the placeholder `API_KEY` in `lib/provider/course_provider.dart` and `lib/screen/read_page.dart` with your actual Google Generative AI API key. For security, consider using a `.env` file with `flutter_dotenv`:
     ```dart
     final model = GenerativeModel(
       model: 'gemini-1.5-flash-latest',
       apiKey: 'YOUR_API_KEY_HERE',
     );
     ```

5. **Enable Platform Support**:
   - For web:
     ```bash
     flutter config --enable-web
     ```
   - For Android: Ensure your `android/app/build.gradle` is configured correctly for Firebase.

6. **Run the App**:
   Start the app on your desired platform (e.g., web or Android):
   ```bash
   flutter run -d chrome
   ```
   or
   ```bash
   flutter run -d <android-device>
   ```

## Usage
1. **Launch the App**: Open the app on your chosen platform.
2. **Register/Login**: From the landing screen, navigate to the registration screen to create an account or log in with existing credentials.
3. **Add a Course**: On the home screen, click the "Add Course" floating action button to create a new course by specifying its name, focus (optional), and difficulty level.
4. **View Learning Plan**: After creating a course, view the AI-generated learning plan in Markdown format, including key concepts, examples, and resources.
5. **Generate Quizzes**: From the learning plan screen, click "Generate Quizzes" to create 5-10 quizzes based on the course content.
6. **Manage Courses**: View all courses in a list, tap to view details, or delete courses using the delete icon.
7. **Logout**: Use the drawer’s "Logout" option to sign out and return to the landing screen.

## Project Structure
```
gem-study/
├── asset/
│   └── img1.png                # Image for landing screen
├── lib/
│   ├── firebase_options.dart    # Firebase configuration for web and Android
│   ├── main.dart               # App entry point and authentication gate
│   ├── login/
│   │   ├── login.dart          # Login screen UI
│   │   └── register.dart       # Registration screen UI
│   ├── provider/
│   │   ├── course_provider.dart # Manages course creation and AI content generation
│   │   ├── gen_provider.dart    # Utility for showing snackbars
│   │   ├── home_provider.dart   # Manages home screen state (e.g., refresh)
│   │   ├── login_provider.dart  # Handles login logic
│   │   └── register_provider.dart # Handles registration logic
│   ├── screen/
│   │   ├── addcourse.dart      # Screen for adding new courses
│   │   ├── homepage.dart       # Home screen with course list
│   │   ├── landing.dart        # Landing screen for unauthenticated users
│   │   └── read_page.dart      # Displays AI-generated Markdown content
├── pubspec.yaml                # Project dependencies and configuration
├── README.md                   # This file
```

## Dependencies
Add these to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.0
  firebase_auth: ^4.15.0
  cloud_firestore: ^4.13.0
  google_generative_ai: ^0.4.0
  provider: ^6.1.0
  markdown_widget: ^2.0.0
  intl: ^0.18.0
```

## Notes
- **Security**:
  - Avoid hardcoding API keys in production. Use environment variables or a secure configuration method (e.g., `flutter_dotenv`).
  - The `password` field is stored in Firestore in `register_provider.dart`, which is insecure. Consider removing it, as Firebase Authentication already handles passwords securely.
- **Error Handling**: Enhance error handling in `course_provider.dart` and `read_page.dart` for API failures or network issues.
- **Platform Support**: The app supports web and Android (based on `firebase_options.dart`). iOS, macOS, Windows, and Linux are not configured.
- **Commented Code**: Remove unused commented code in `landing.dart` and `read_page.dart` to clean up the codebase.
- **Assets**: Ensure the `asset/img1.png` file exists for the landing screen, and declare it in `pubspec.yaml`:
  ```yaml
  flutter:
    assets:
      - asset/img1.png
  ```

## Contributing
Contributions are welcome! Please submit a pull request or open an issue for bug reports, feature requests, or improvements.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
