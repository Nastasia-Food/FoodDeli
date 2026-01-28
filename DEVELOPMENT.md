# Development Guide

This guide provides instructions for setting up and developing the FoodDeli application.

## Prerequisites

Before you begin, ensure you have the following installed:
- Flutter SDK (version 3.4.0 or higher)
- Dart SDK
- Android Studio or VS Code with Flutter extensions
- Xcode (for iOS development)
- Firebase CLI tools

## Project Setup

### 1. Clone the Repository
```bash
git clone https://github.com/Nastasia-Food/FoodDeli.git
cd FoodDeli
```

### 2. Install Dependencies
```bash
flutter pub get
```

### 3. Firebase Configuration
1. Create a Firebase project at https://console.firebase.google.com/
2. Add Android and iOS apps to your Firebase project
3. Download `google-services.json` and place it in `android/app/`
4. Download `GoogleService-Info.plist` and place it in `ios/Runner/`
5. Update Firebase configuration in `lib/config/firebase_config.dart`

### 4. Environment Configuration
Create a `.env` file in the root directory with the following variables:
```
API_BASE_URL=your_api_base_url
GOOGLE_MAPS_API_KEY=your_google_maps_api_key
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
```

## Project Structure

```
lib/
├── app/
│   ├── data/
│   │   ├── api/           # API service definitions
│   │   ├── model/         # Data models
│   │   └── repository/    # Data repositories
│   ├── modules/           # Feature modules
│   │   ├── auth/          # Authentication module
│   │   ├── dashboard/     # Dashboard module
│   │   ├── home/           # Home and order module
│   │   ├── profile/         # Profile module
│   │   └── splash/         # Splash screen module
│   ├── routes/            # Application routing
│   └── utils/             # Utility functions
├── helper/                # Helper functions
└── widgets/               # Reusable widgets
```

## Development Workflow

### Running the Application
```bash
# Run on default device
flutter run

# Run on specific device
flutter run -d <device_name>

# Run in debug mode
flutter run --debug

# Run in release mode
flutter run --release
```

### Building the Application
```bash
# Build APK
flutter build apk

# Build for iOS
flutter build ios

# Build for web
flutter build web
```

## Code Standards

### Dart Code Style
- Follow the official Dart style guide
- Use meaningful variable and function names
- Keep functions small and focused
- Add comments for complex logic
- Use proper error handling

### Widget Structure
- Separate widgets into logical components
- Use const constructors where possible
- Implement proper state management
- Follow Flutter's composition pattern

### State Management
- Use GetX for state management
- Separate business logic from UI
- Use controllers for complex logic
- Implement proper dependency injection

## Testing

### Running Tests
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Run specific test file
flutter test test/widget_test.dart
```

### Test Structure
```
test/
├── unit/                  # Unit tests
├── widget/               # Widget tests
└── integration/          # Integration tests
```

### Writing Tests
- Write unit tests for business logic
- Write widget tests for UI components
- Write integration tests for critical user flows
- Maintain high test coverage

## Debugging

### Common Debugging Commands
```bash
# Enable debugging
flutter run --debug

# Check for errors
flutter doctor

# Analyze code
flutter analyze

# Format code
flutter format .
```

### Logging
- Use the logging package for debug output
- Implement proper log levels (debug, info, warning, error)
- Remove debug logs before production

## Contributing Code

### Git Workflow
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Write tests
5. Commit your changes
6. Push to your fork
7. Create a pull request

### Commit Messages
- Use clear, descriptive commit messages
- Follow conventional commit format
- Reference issues when applicable
- Keep commits focused on single changes

### Pull Request Process
1. Ensure all tests pass
2. Update documentation if needed
3. Follow the pull request template
4. Request review from maintainers

## Internationalization

### Adding New Languages
1. Create a new language file in `lib/localization/`
2. Add translations for all strings
3. Update `lib/localization/language.dart`
4. Test the new language

### Updating Translations
- Keep all language files in sync
- Use consistent terminology
- Test all supported languages

## Performance Optimization

### Best Practices
- Use const widgets where possible
- Implement proper image caching
- Avoid unnecessary rebuilds
- Use lazy loading for lists
- Optimize network requests

### Profiling
- Use Flutter DevTools for performance analysis
- Monitor memory usage
- Identify performance bottlenecks
- Optimize rendering performance

## Troubleshooting

### Common Issues
1. **Firebase configuration errors**
   - Verify all configuration files are in place
   - Check Firebase project settings
   - Ensure proper permissions

2. **Build failures**
   - Run `flutter clean` and rebuild
   - Check for dependency conflicts
   - Verify Flutter installation

3. **Runtime errors**
   - Check logs with `flutter logs`
   - Verify device compatibility
   - Test on multiple devices

### Getting Help
- Check the SUPPORT.md file
- Review existing issues
- Contact the development team

## Release Process

### Pre-release Checklist
- Update version in `pubspec.yaml`
- Update CHANGELOG.md
- Run all tests
- Verify all features work
- Check documentation is up to date

### Deployment
- Create release builds
- Upload to app stores
- Monitor for issues
- Announce release

This guide will be updated as development practices evolve.