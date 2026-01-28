# Deployment Guide

This document provides comprehensive guidance for deploying the FoodDeli food delivery application.

## Overview

The FoodDeli deployment process involves building, testing, and publishing the application to various platforms including iOS App Store, Google Play Store, and web platforms. This guide covers all aspects of the deployment pipeline.

## Deployment Architecture

### Multi-Platform Deployment
```
                    ┌─────────────────┐
                    │   Development   │
                    │    (Flutter)    │
                    └─────────┬───────┘
                              │
                    ┌─────────▼───────┐
                    │  Build System   │
                    │ (GitHub Actions)│
                    └─────────┬───────┘
                              │
        ┌─────────────────────┼─────────────────────┐
        │                     │                     │
┌───────▼────────┐   ┌────────▼────────┐   ┌──────▼────────┐
│ iOS Deployment │   │Android Deployment│   │ Web Deployment│
│  (App Store)   │   │ (Google Play)    │   │   (Firebase) │
└────────────────┘   └─────────────────┘   └───────────────┘
```

### Environment Hierarchy
1. **Development**: Local development environment
2. **Staging**: Pre-production testing environment
3. **Production**: Live application environment

## Prerequisites

### Development Tools
- **Flutter SDK**: Version 3.4.0 or higher
- **Dart SDK**: Compatible with Flutter version
- **Android Studio**: For Android development
- **Xcode**: For iOS development (macOS only)
- **Firebase CLI**: For Firebase deployment

### Accounts and Keys
- **Apple Developer Account**: For iOS deployment
- **Google Play Console**: For Android deployment
- **Firebase Project**: For backend services
- **Code Signing Certificates**: For app signing
- **API Keys**: For third-party services

### Environment Variables
```bash
# Firebase Configuration
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_project.firebaseapp.com
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_project.appspot.com
FIREBASE_MESSAGING_SENDER_ID=sender_id
FIREBASE_APP_ID=app_id

# Payment Gateway
STRIPE_PUBLISHABLE_KEY=pk_test_your_key
RAZORPAY_KEY_ID=rzp_test_your_key

# Maps and Location
GOOGLE_MAPS_API_KEY=your_maps_api_key

# Analytics and Monitoring
SENTRY_DSN=https://your_sentry_dsn
MIXPANEL_TOKEN=your_mixpanel_token
```

## Build Process

### Version Management
```yaml
# pubspec.yaml
version: 3.0.1+12

# Version Format: MAJOR.MINOR.PATCH+BUILD_NUMBER
# MAJOR: Breaking changes
# MINOR: New features
# PATCH: Bug fixes
# BUILD_NUMBER: Incremental build number
```

### Build Commands
```bash
# Development Build
flutter build apk --debug
flutter build ios --debug

# Release Build
flutter build apk --release
flutter build ios --release
flutter build web --release

# App Bundle (Android)
flutter build appbundle --release

# Specific Architecture (Android)
flutter build apk --release --split-per-abi
```

### Code Signing
#### Android
```gradle
// android/app/build.gradle
android {
    signingConfigs {
        release {
            keyAlias System.getenv("KEY_ALIAS")
            keyPassword System.getenv("KEY_PASSWORD")
            storeFile file(System.getenv("KEYSTORE_PATH"))
            storePassword System.getenv("KEYSTORE_PASSWORD")
        }
    }
}
```

#### iOS
```bash
# Export options for App Store
xcodebuild -exportArchive \
  -archivePath build/ios/xcarchive/Runner.xcarchive \
  -exportPath build/ios/ipa \
  -exportOptionsPlist ExportOptions.plist
```

## Testing Before Deployment

### Automated Testing
```bash
# Run all tests
flutter test

# Run tests with coverage
flutter test --coverage

# Integration tests
flutter test integration_test/

# Widget tests
flutter test test/widget/
```

### Device Testing
- **Firebase Test Lab**: Cloud device testing
- **BrowserStack**: Cross-browser testing
- **Local Devices**: Physical device testing

### Performance Testing
```bash
# Profile the app
flutter run --profile

# Analyze performance
flutter analyze

# Check for issues
flutter doctor
```

## Deployment Pipelines

### GitHub Actions
```yaml
# .github/workflows/deploy.yml
name: Deploy
on:
  push:
    tags:
      - 'v*'

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: subosito/flutter-action@v2
      - run: flutter pub get
      - run: flutter build appbundle --release
      - run: flutter build ios --release --no-codesign
```

### Codemagic
```yaml
# codemagic.yaml
workflows:
  fooddeli-deployment:
    name: FoodDeli Deployment
    max_build_duration: 60
    instance_type: mac_mini_m1
    environment:
      flutter: 3.4.0
    triggering:
      events:
        - tag
      tag_patterns:
        - pattern: 'v*'
    scripts:
      - name: Set up code signing
        script: |
          keychain initialize
          app-store-connect fetch-signing-files
      - name: Build iOS
        script: flutter build ios --release
      - name: Build Android
        script: flutter build appbundle --release
    publishing:
      app_store_connect:
        api_key: $APP_STORE_CONNECT_API_KEY
      google_play:
        credentials: $GOOGLE_PLAY_CREDENTIALS
```

## Platform-Specific Deployment

### iOS Deployment
#### App Store Connect
1. **Prepare Assets**
   - App Store screenshots
   - App icon (1024x1024)
   - Promotional text

2. **Configure App Store Listing**
   - App name and description
   - Keywords and categories
   - Privacy policy URL
   - Support URL

3. **Submit for Review**
   - Upload build via Xcode or Transporter
   - Complete App Store Connect form
   - Submit for review

#### Code Signing
```bash
# Generate signing certificates
xcodebuild -exportArchive \
  -archivePath build/ios/xcarchive/Runner.xcarchive \
  -exportPath build/ios/ipa \
  -exportOptionsPlist ExportOptions.plist
```

### Android Deployment
#### Google Play Console
1. **Prepare Store Listing**
   - High-resolution app icon
   - Screenshots for various devices
   - Feature graphics
   - Promotional videos

2. **Content Rating**
   - Complete content rating questionnaire
   - Provide age restrictions
   - Declare ads and in-app purchases

3. **Upload Releases**
   - Internal testing track
   - Closed testing track
   - Production track

#### App Signing
```bash
# Generate signed APK
flutter build apk --release \
  --keystore=keystore.jks \
  --keyalias=key_alias \
  --store-password=store_password \
  --key-password=key_password
```

### Web Deployment
#### Firebase Hosting
1. **Configure Firebase**
   ```bash
   firebase init hosting
   ```

2. **Deploy to Firebase**
   ```bash
   firebase deploy --only hosting
   ```

3. **Custom Domain**
   - Configure custom domain in Firebase Console
   - Update DNS records
   - Verify domain ownership

## Environment Management

### Configuration Management
```dart
// lib/config/environment.dart
class Environment {
  static const String apiUrl = String.fromEnvironment(
    'API_URL',
    defaultValue: 'https://api.fooddeli.example.com',
  );
  
  static const bool isDebug = bool.fromEnvironment(
    'DEBUG',
    defaultValue: false,
  );
}
```

### Feature Flags
```dart
// lib/config/feature_flags.dart
class FeatureFlags {
  static const bool newUI = bool.fromEnvironment(
    'FEATURE_NEW_UI',
    defaultValue: false,
  );
  
  static const bool advancedTracking = bool.fromEnvironment(
    'FEATURE_ADVANCED_TRACKING',
    defaultValue: false,
  );
}
```

## Monitoring and Analytics

### Post-Deployment Monitoring
- **Crash Reporting**: Firebase Crashlytics
- **Performance Monitoring**: Firebase Performance
- **User Analytics**: Firebase Analytics
- **Error Tracking**: Sentry or similar

### Health Checks
```bash
# Verify deployment
curl -I https://your-app.firebaseapp.com

# Check API endpoints
curl https://api.fooddeli.example.com/health
```

## Rollback Procedures

### Version Rollback
1. **Identify Issue**
   - Monitor crash reports
   - Check user feedback
   - Review analytics

2. **Rollback Process**
   - Revert to previous version in App Store/Play Store
   - Update backend services if needed
   - Communicate with users

### Hotfix Deployment
1. **Create Hotfix Branch**
   ```bash
   git checkout -b hotfix/v3.0.2 main
   ```

2. **Implement Fix**
   - Apply minimal changes
   - Test thoroughly
   - Create new build

3. **Deploy Hotfix**
   - Submit to app stores
   - Monitor deployment
   - Verify fix

## Security Considerations

### Secure Deployment
- **Secrets Management**: Use environment variables
- **Code Signing**: Verify all builds
- **Access Control**: Limit deployment access
- **Audit Logs**: Track all deployments

### Compliance
- **Privacy Policy**: Update for new features
- **Data Protection**: Ensure GDPR compliance
- **Security Audits**: Regular security reviews

## Troubleshooting

### Common Deployment Issues
1. **Code Signing Errors**
   - Verify certificates
   - Check keychain access
   - Update provisioning profiles

2. **Build Failures**
   - Check dependencies
   - Verify Flutter version
   - Review build logs

3. **App Store Rejection**
   - Review guidelines
   - Fix reported issues
   - Resubmit with explanations

### Recovery Procedures
1. **Failed Deployment**
   - Rollback to previous version
   - Investigate root cause
   - Implement fix

2. **Performance Issues**
   - Monitor metrics
   - Identify bottlenecks
   - Optimize code

3. **Security Incidents**
   - Contain incident
   - Investigate breach
   - Implement fixes

## Best Practices

### Deployment Checklist
- [ ] All tests passing
- [ ] Code review completed
- [ ] Security review completed
- [ ] Performance testing completed
- [ ] Documentation updated
- [ ] Version numbers updated
- [ ] Release notes prepared
- [ ] Stakeholder approval obtained

### Post-Deployment
- [ ] Monitor application performance
- [ ] Check user feedback
- [ ] Verify all features working
- [ ] Update documentation
- [ ] Communicate with team

This deployment guide will be updated regularly to reflect new deployment practices, tools, and requirements.