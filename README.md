# Neural Boost

**Neural Boost** is a mobile application developed as a semester project to fulfill the requirements of Mobile Development and Medical Informatics Application Development. The app is designed to assist individuals in managing ADHD symptoms through interactive features, cognitive training games, and structured task management. By combining medical assessment tools with engaging activities, Neural Boost aims to provide a comprehensive support system for users while making personal development rewarding and enjoyable.

## Key Features

- **ADHD Questionnaires**: Interactive assessment tools to evaluate ADHD symptoms
- **Cognitive Training Games**: Mini games designed to improve focus and attention
- **Task Management**: Todo-list system to help users organize and track their activities
- **Gamification System**: Point-based rewards system to motivate and engage users

## Technologies Used

- **Flutter**: Version 3.24.5
- **Dart**: Primary programming language
- **Firebase**: Backend services including Authentication, Realtime Database, and Cloud Storage
- **Flutter Secure Storage**: For secure local data storage
- **Additional Dependencies**: Listed in pubspec.yaml

## System Requirements

- **Java JDK**: Version 19 or higher
- **Gradle**: Version 8.0 or higher
- **Flutter SDK**: Version 3.24.5 or higher
- **Android Studio** or **VS Code** with Flutter extensions
- **Xcode** (for iOS development, macOS only)

## CRITICAL: Security Configuration

**IMPORTANT**: This repository does NOT include Firebase configuration files with actual API keys. You must configure Firebase locally before running the application.

### Required Configuration Files (Not in Git)

The following files contain sensitive API keys and are excluded from version control:

1. `android/app/google-services.json` - Android Firebase configuration
2. `lib/firebase_options.dart` - Flutter Firebase options for all platforms
3. `ios/Runner/GoogleService-Info.plist` - iOS Firebase configuration
4. `web/index.html` - Web Firebase configuration (with actual API keys)

### Firebase Setup Instructions

#### Step 1: Create or Access Firebase Project

1. Visit [Firebase Console](https://console.firebase.google.com/)
2. Create a new project or select your existing project
3. Go to Project Settings

#### Step 2: Configure Firebase for Flutter

Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

Configure your project (automatically generates required files):
```bash
flutterfire configure
```

This command will:
- Connect to your Firebase project
- Generate `lib/firebase_options.dart` with your credentials
- Configure platform-specific settings

#### Step 3: Download Platform-Specific Configuration Files

**For Android:**
1. In Firebase Console, go to Project Settings > Your apps > Android app
2. Download `google-services.json`
3. Place it in: `android/app/google-services.json`

**For iOS:**
1. In Firebase Console, go to Project Settings > Your apps > iOS app
2. Download `GoogleService-Info.plist`
3. Place it in: `ios/Runner/GoogleService-Info.plist`

**For Web:**
1. In Firebase Console, go to Project Settings > Your apps > Web app
2. Copy the Firebase configuration object
3. Update the `firebaseConfig` in `web/index.html`

### API Key Security Best Practices

**CRITICAL**: Always restrict your Firebase API keys in Google Cloud Console:

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Navigate to **APIs & Services > Credentials**
3. For each API key, configure:
   - **Application restrictions**: Limit to specific platforms (Android package name, iOS bundle ID, or HTTP referrers)
   - **API restrictions**: Only enable required APIs (Firebase, Analytics, etc.)

**Recommended Restrictions:**
- **Android Key**: Restrict to package name `com.ntr.neuralboost`
- **iOS Key**: Restrict to bundle ID `com.ntr.neuralboost`
- **Web Key**: Restrict to your specific domain(s)

### Firebase Security Rules
Configure your Firebase Realtime Database with these security rules:

```json
{
  "rules": {
    ".read": "auth != null",
    ".write": "auth != null",
    "users": {
      "$uid": {
        ".read": "$uid === auth.uid",
        ".write": "$uid === auth.uid",
        "id": { ".validate": "newData.isString()" },
        "email": { ".validate": "newData.isString()" },
        "points": { ".validate": "newData.isNumber()" },
        "adhdStatus": { ".validate": "newData.isString()" },
        "dateResponded": { ".validate": "newData.isString()" },
        "level": { ".validate": "newData.isString()" },
        "unlockedThemes": { ".validate": "newData.isString()" },
        "todos": {
          "$todoId": {
            "title": { ".validate": "newData.isString()" },
            "description": { ".validate": "newData.isString()" },
            "targetDate": { ".validate": "newData.isString()" },
            "isCompleted": { ".validate": "newData.isBoolean()" }
          }
        }
      }
    },
    "questionnaire_responses": {
      "$responseId": {
        ".read": "auth != null",
        ".write": "auth != null",
        "responses": { ".validate": "newData.hasChildren()" },
        "adhdStatus": { ".validate": "newData.isString()" },
        "dateResponded": { ".validate": "newData.isString()" },
        "userId": { ".validate": "newData.isString() && newData.val() === auth.uid" }
      },
      ".indexOn": ["userId"]
    }
  }
}
```

**Security Rules Overview:**
- **Authentication Required**: All read and write operations require user authentication
- **User Data Protection**: Users can only access and modify their own data
- **Data Validation**: Enforces data types and structure for all user inputs

### Additional Security Measures

1. **Enable Firebase App Check**
   - Protects backend resources from abuse
   - Configure in Firebase Console > Build > App Check

2. **Monitor API Usage**
   - Set up alerts in Google Cloud Console > APIs & Services > Dashboard
   - Monitor for unusual patterns or excessive usage
   - Configure billing alerts

3. **Enable 2FA**
   - Secure your Firebase/Google account with Two-Factor Authentication
   - Go to Google Account > Security > 2-Step Verification

## Installation

Follow these steps to run the project locally:

### Prerequisites

Ensure you have completed the Firebase setup above before proceeding.

### Steps

1. Clone the repository:
```bash
git clone https://github.com/elnoersan/neuralboost.git
```

2. Navigate to the project directory:
```bash
cd neuralboost
```

3. Install dependencies:
```bash
flutter pub get
```

4. Configure Firebase (if not done already):
```bash
flutterfire configure
```

5. Run the application on an emulator or physical device:
```bash
flutter run
```

## Project Structure

```
neuralboost/
├── lib/
│   ├── main.dart                 # Application entry point
│   ├── firebase_options.dart     # Firebase configuration (not in git)
│   ├── models/                   # Data models
│   │   ├── user.dart
│   │   ├── todo_model.dart
│   │   └── questionnaire_response.dart
│   ├── screens/                  # UI screens
│   │   ├── home_screen.dart
│   │   ├── login_sign_up_screen.dart
│   │   ├── profile_screen.dart
│   │   ├── questionnaire_screen.dart
│   │   ├── todo_list_screen.dart
│   │   └── shop_screen.dart
│   ├── services/                 # Business logic
│   │   ├── auth_service.dart
│   │   ├── gamificate_service.dart
│   │   ├── questionnaire_service.dart
│   │   └── todo_view_model.dart
│   ├── widgets/                  # Reusable components
│   └── utils/                    # Utilities and constants
│       ├── app_theme.dart
│       └── constants.dart
├── android/                      # Android platform files
├── ios/                          # iOS platform files
├── web/                          # Web platform files
├── assets/                       # Images, fonts, and other assets
│   ├── fonts/
│   └── images/
└── pubspec.yaml                  # Dependencies configuration
```

## Development

### Running Tests

```bash
flutter test
```

### Building for Production

**Android:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Web:**
```bash
flutter build web
```

## Contribution

We welcome contributions from everyone. If you would like to contribute:

1. Fork the repository

2. Create a new branch for your feature or bug fix:
```bash
git checkout -b feature/new-feature
```

3. Make your changes and commit:
```bash
git commit -m "Add new feature"
```

4. Push to your branch:
```bash
git push origin feature/new-feature
```

5. Open a pull request with a clear description of your changes

### Contribution Guidelines

- Follow Flutter style guidelines
- Write clear commit messages
- Add tests for new features
- Update documentation as needed
- Ensure all tests pass before submitting PR

## Troubleshooting

### Common Issues

**Issue: Firebase configuration missing**
- Solution: Run `flutterfire configure` and ensure all platform-specific files are in place

**Issue: Build fails on Android**
- Solution: Check Java JDK version (should be 19) and Gradle version (should be 8.0+)

**Issue: API key errors**
- Solution: Verify API keys are properly restricted in Google Cloud Console

## License

This project is licensed under the MIT License.

## References

- [Official Flutter Documentation](https://flutter.dev/docs)
- [Firebase Documentation](https://firebase.google.com/docs)
- [Flutter Cookbook](https://flutter.dev/docs/cookbook)
- [Google Cloud Security Best Practices](https://cloud.google.com/docs/authentication/api-keys)

## Team

Developed by **NTR "Neural Tech Revolution"**

## Support

For questions or issues, please open an issue on GitHub or contact the development team.

## Note

I know this is jokes actually have fun
