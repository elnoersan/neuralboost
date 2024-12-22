# Neural Boost

**Neural Boost**  is a mobile application developed as a semester project to fulfill the requirements of Mobile Development and Medical Informatics Application Development. The app is designed to assist individuals in managing ADHD symptoms through interactive features, cognitive training games, and structured task management. By combining medical assessment tools with engaging activities, Neural Boost aims to provide a comprehensive support system for users while making personal development rewarding and enjoyable.

## 📋 Key Features

- **Main Feature 1**: ADHD Questionnaries
- **Feature 2**: Mini games for training user focus
- **Feature 3**: Todo-list for help user manage their activities
- **Feature 3**: Pointfication activity of user to make user feels get rewards

## 🛠️ Technologies Used

- **Flutter**: Version 3.24.5
- **Dart**
- **Other Frameworks/Libraries**: *(List any additional technologies if used)*

## ⚙️ System Requirements

- **Java JDK**: Version 19
- **Gradle**: Version 8.0
- **Flutter SDK**: Version 3.24.5 or higher

🔒 Firebase Rules
Configure your Firebase Realtime Database with these security rules:
```json
jsonCopy{
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
Security Rules Overview

Authentication Required: All read and write operations require user authentication
User Data Protection: Users can only access and modify their own data
Data Validation:

User profiles include validated fields for ID, email, points, ADHD status, and more
Todo items require title, description, target date, and completion status
Questionnaire responses are validated and indexed by user ID

## 🚀 Installation

Follow these steps to run the project locally:

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

4. Run the application on an emulator or a physical device:
```bash
flutter run
```

## 📂 Project Structure

- **lib/**: Contains the main source code for the application.
- **assets/**: Includes assets such as images or additional files.
- **android/, ios/, web/**: Platform-specific directories for builds.

## 🤝 Contribution

We welcome contributions from everyone. If you would like to contribute:

1. Fork the repository.
2. Create a new branch for your feature or bug fix:
```bash
git checkout -b new-feature
```

3. Commit your changes:
```bash
git commit -m "Add new feature"
```

4. Push to your branch:
```bash
git push origin new-feature
```

5. Open a pull request.

## 📜 License

This project is licensed under the MIT License.

## 📚 References

- [Official Flutter Documentation](https://flutter.dev/docs)
- [Lab: Write Your First Flutter App](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter Samples](https://flutter.dev/docs/cookbook)

Developed with ❤️ by NTR "Neural Tech Revolution"
