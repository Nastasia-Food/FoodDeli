# Project Configuration

This document describes the configuration files and settings used in the FoodDeli project.

## Overview

The FoodDeli project uses various configuration files to manage dependencies, build settings, and development environments. This document provides an overview of these configurations.

## Flutter Configuration

### pubspec.yaml
The main configuration file for Flutter projects.

```yaml
name: foodking_delivery_boy
version: 3.0.1+12
publish_to: none
description: At its core, the NataLee Pro Food Ecosystem is driven by a mission to redefine global food systems. It aims to bridge the gap between cutting-edge food technologies and traditional culinary practices, fostering a harmonious relationship between humans and the planet.

environment: 
  sdk: '>=3.4.0 <4.0.0'

dependencies: 
  cupertino_icons: ^1.0.2
  get: ^4.7.3
  http: ^1.6.0
  animated_bottom_navigation_bar: ^1.1.0
  flutter_screenutil: ^5.9.0
  image_picker: ^1.2.1
  get_storage: ^2.0.3
  flutter_svg: ^2.2.3
  lottie: ^3.3.2
  modal_bottom_sheet: ^3.0.0
  expansion_tile_card: ^3.0.0
  bottom_bar: ^2.0.5
  rflutter_alert: ^2.0.4
  cached_network_image: ^3.3.1
  shimmer: ^3.0.0
  connectivity_plus: ^7.0.0
  firebase_messaging: ^16.1.1
  firebase_core: ^4.2.1
  flutter_local_notifications: ^20.0.0
  flutter_launcher_icons: ^0.14.4
  google_maps_flutter: ^2.14.0
  location: ^7.0.1
  geolocator: ^14.0.2
  flutter_polyline_points: ^3.1.0
  url_launcher: ^6.3.2
  map_launcher: ^4.4.2
  webview_flutter: ^4.13.1
  flutter_html: 3.0.0

  flutter: 
    sdk: flutter

dev_dependencies: 
  flutter_lints: ^6.0.0
  flutter_test: 
    sdk: flutter

flutter_icons:
  image_path: "assets/images/app_logo.png"
  android: "ic_launcher"
  ios: true

flutter: 
  uses-material-design: true

  assets:
    - assets/images/
    - assets/icons/

  fonts:
    - family: Rubik
      fonts:
        - asset: assets/fonts/Rubik-Regular.ttf
          weight: 400
        - asset: assets/fonts/Rubik-Medium.ttf
          weight: 500
        - asset: assets/fonts/Rubik-Bold.ttf
          weight: 700
        - asset: assets/fonts/Rubik-Black.ttf
          weight: 900
```

## Firebase Configuration

### Firebase Project Settings
Firebase configuration is managed through the Firebase Console and the following files:

1. **android/app/google-services.json** - Android Firebase configuration
2. **ios/Runner/GoogleService-Info.plist** - iOS Firebase configuration
3. **ios/Runner/GoogleService-Info.plist** - iOS Firebase configuration (duplicate for different targets)

### Firebase Services Used
- **Firestore**: Primary database
- **Authentication**: User authentication
- **Cloud Messaging**: Push notifications
- **Storage**: Image storage
- **Functions**: Serverless functions
- **Analytics**: User analytics

## Environment Configuration

### .env File
Environment variables are managed through a .env file:

```env
# API Configuration
API_BASE_URL=https://api.fooddeli.example.com
API_TIMEOUT=30000

# Firebase Configuration
FIREBASE_API_KEY=your_api_key
FIREBASE_AUTH_DOMAIN=your_auth_domain
FIREBASE_PROJECT_ID=your_project_id
FIREBASE_STORAGE_BUCKET=your_storage_bucket
FIREBASE_MESSAGING_SENDER_ID=your_messaging_sender_id
FIREBASE_APP_ID=your_app_id

# Google Maps
GOOGLE_MAPS_API_KEY=your_google_maps_api_key

# Payment Gateways
STRIPE_PUBLISHABLE_KEY=your_stripe_publishable_key
RAZORPAY_KEY_ID=your_razorpay_key_id

# Third-party Services
SENTRY_DSN=your_sentry_dsn
MIXPANEL_TOKEN=your_mixpanel_token

# Feature Flags
FEATURE_NEW_UI=true
FEATURE_ADVANCED_TRACKING=false
```

## Build Configuration

### Android Build Configuration
Located in `android/app/build.gradle`:

```gradle
android {
    compileSdkVersion 34
    ndkVersion flutter.ndkVersion

    compileOptions {
        sourceCompatibility JavaVersion.VERSION_1_8
        targetCompatibility JavaVersion.VERSION_1_8
    }

    kotlinOptions {
        jvmTarget = '1.8'
    }

    sourceSets {
        main.java.srcDirs += 'src/main/kotlin'
    }

    defaultConfig {
        applicationId "com.nata.food"
        minSdkVersion 21
        targetSdkVersion 34
        versionCode flutterVersionCode.toInteger()
        versionName flutterVersionName
    }

    buildTypes {
        release {
            signingConfig signingConfigs.debug
        }
    }
}
```

### iOS Build Configuration
Located in `ios/Runner.xcodeproj/project.pbxproj` and various plist files.

### Codemagic Configuration
Located in `codemagic.yaml`:

```yaml
workflows:
  fooddeli-workflow:
    name: FoodDeli Workflow
    max_build_duration: 60
    instance_type: mac_mini_m1
    environment:
      flutter: 3.4.0
      xcode: latest
      cocoapods: default
    triggering:
      events:
        - push
        - pull_request
      branch_patterns:
        - pattern: main
          include: true
        - pattern: develop
          include: true
    scripts:
      - name: Get Flutter packages
        script: flutter pub get
      - name: Run tests
        script: flutter test
      - name: Build Android
        script: flutter build appbundle --release
      - name: Build iOS
        script: flutter build ios --release --no-codesign
    artifacts:
      - build/app/outputs/flutter-apk/app-release.apk
      - build/ios/ipa/*.ipa
    publishing:
      email:
        recipients:
          - support@rechain.network
```

## Analysis Configuration

### analysis_options.yaml
Dart analysis configuration:

```yaml
include: package:flutter_lints/flutter.yaml

analyzer:
  strong-mode:
    implicit-casts: false
    implicit-dynamic: false
  errors:
    todo: ignore
  exclude:
    - lib/generated_plugin_registrant.dart

linter:
  rules:
    # Comprehensive list of linter rules
    # See CODE_QUALITY.md for full list
```

## Editor Configuration

### .editorconfig
Editor configuration for consistent coding styles:

```ini
root = true

[*]
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true

[*.dart]
indent_style = space
indent_size = 2
```

## Git Configuration

### .gitattributes
Git attributes for proper file handling:

```gitattributes
* text=auto
*.pbxproj binary
*.ipa binary
*.apk binary
```

### .gitignore
Files and directories to ignore:

```gitignore
# Flutter/Dart/Pub related
**/doc/api/
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
/build/
/flutter_*.png
/generated/

# IDE related
.vscode/
.idea/
*.swp
*.swo
```

## Testing Configuration

### Test Environment
Testing configuration in `pubspec.yaml`:

```yaml
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^6.0.0
  mockito: ^5.4.0
  integration_test:
    sdk: flutter
```

### Test Coverage
Coverage configuration and thresholds:

```bash
# Run tests with coverage
flutter test --coverage

# Generate HTML coverage report
genhtml coverage/lcov.info -o coverage/html
```

## Documentation Configuration

### Markdown Linting
Markdown linting configuration in `.markdownlint.json`:

```json
{
  "default": true,
  "MD013": false,
  "MD033": false,
  "MD041": false
}
```

### Documentation Generation
Documentation generation configuration:

```yaml
# dartdoc configuration
dartdoc:
  include: ['lib/']
  exclude: ['lib/src/generated/']
  validate-links: true
```

## Deployment Configuration

### App Store Configuration
App Store deployment configuration:

```xml
<!-- iOS App Store -->
<key>ITSAppUsesNonExemptEncryption</key>
<false/>
```

### Google Play Configuration
Google Play deployment configuration:

```json
{
  "versionCode": 12,
  "versionName": "3.0.1",
  "minSdkVersion": 21,
  "targetSdkVersion": 34
}
```

## Security Configuration

### Code Signing
Code signing configuration for various platforms.

### Secrets Management
Secrets management through environment variables and secure storage.

## Performance Configuration

### Build Optimization
Build optimization settings for faster builds and smaller app sizes.

### Asset Optimization
Asset optimization configuration for images and other resources.

## Accessibility Configuration

### Accessibility Standards
Accessibility configuration to meet WCAG standards.

### Testing Configuration
Accessibility testing configuration and tools.

This project configuration documentation will be updated as configurations evolve and new requirements are identified.