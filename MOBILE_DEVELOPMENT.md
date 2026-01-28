# Mobile Development

This document provides comprehensive guidance for mobile development of the FoodDeli food delivery application.

## Overview

FoodDeli is a cross-platform mobile application built with Flutter, targeting both iOS and Android platforms. This document covers mobile-specific development practices, platform considerations, and optimization techniques.

## Platform Considerations

### iOS vs Android Differences

#### Design Guidelines
- **iOS**: Follow Human Interface Guidelines
- **Android**: Follow Material Design Guidelines
- **Cross-platform**: Maintain consistent UX

#### Navigation Patterns
- **iOS**: Navigation stack with back button
- **Android**: Bottom navigation with back button
- **Cross-platform**: Adaptive navigation

#### UI Components
- **iOS**: Cupertino widgets
- **Android**: Material widgets
- **Cross-platform**: Platform-adaptive widgets

### Platform-Specific Features

#### iOS Features
- **Haptic Feedback**: Taptic Engine integration
- **Siri Shortcuts**: Voice command support
- **Apple Pay**: Native payment integration
- **HealthKit**: Health data integration (if applicable)

#### Android Features
- **Google Play Services**: Location, maps, and services
- **Google Pay**: Native payment integration
- **Notifications**: Rich notifications with actions
- **Widgets**: Home screen widgets

## Performance Optimization

### Rendering Optimization
```dart
// Use const constructors where possible
const Text('Hello World')

// Use ListView.builder for large lists
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) => ItemWidget(items[index]),
)

// Use FutureBuilder for async data
FutureBuilder(
  future: fetchData(),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return DataWidget(snapshot.data);
    }
    return LoadingWidget();
  },
)
```

### Memory Management
```dart
// Dispose of controllers
class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final controller = TextEditingController();
  
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
```

### Network Optimization
```dart
// Cache network images
CachedNetworkImage(
  imageUrl: 'https://example.com/image.jpg',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
)

// Use efficient HTTP requests
http.get(Uri.parse('https://api.example.com/data')).timeout(
  Duration(seconds: 10),
  onTimeout: () {
    throw TimeoutException('Request timeout');
  },
)
```

## Mobile-Specific Features

### Location Services
```dart
// Request location permission
final permission = await Geolocator.checkPermission();
if (permission == LocationPermission.denied) {
  await Geolocator.requestPermission();
}

// Get current location
final position = await Geolocator.getCurrentPosition();
```

### Camera Integration
```dart
// Capture image
final image = await ImagePicker().pickImage(source: ImageSource.camera);

// Select from gallery
final image = await ImagePicker().pickImage(source: ImageSource.gallery);
```

### Push Notifications
```dart
// Initialize Firebase Messaging
FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  // Handle foreground message
});

// Request permission
NotificationSettings settings = await messaging.requestPermission();
```

### In-App Purchases
```dart
// Initialize in-app purchases
final ProductDetailsResponse response = await _connection.queryProductDetails(_kProductIds);

// Purchase product
final PurchaseParam purchaseParam = PurchaseParam(productDetails: productDetails);
await _connection.buyNonConsumable(purchaseParam: purchaseParam);
```

## Platform Integration

### iOS Integration
#### AppDelegate Configuration
```swift
// ios/Runner/AppDelegate.swift
import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
```

#### Info.plist Configuration
```xml
<!-- ios/Runner/Info.plist -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>This app needs access to location to provide delivery services.</string>

<key>NSCameraUsageDescription</key>
<string>This app needs access to camera to capture profile photos.</string>

<key>NSPhotoLibraryUsageDescription</key>
<string>This app needs access to photo library to select profile photos.</string>
```

### Android Integration
#### AndroidManifest Configuration
```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
<uses-permission android:name="android.permission.CAMERA" />
<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />

<application
    android:name="${applicationName}"
    android:label="FoodDeli"
    android:icon="@mipmap/ic_launcher">
    
    <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="YOUR_API_KEY" />
        
    <activity
        android:name=".MainActivity"
        android:exported="true"
        android:launchMode="singleTop"
        android:theme="@style/LaunchTheme">
        
        <intent-filter>
            <action android:name="android.intent.action.MAIN"/>
            <category android:name="android.intent.category.LAUNCHER"/>
        </intent-filter>
    </activity>
</application>
```

#### Gradle Configuration
```gradle
// android/app/build.gradle
android {
    compileSdkVersion 34
    
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

dependencies {
    implementation "org.jetbrains.kotlin:kotlin-stdlib-jdk7:$kotlin_version"
}
```

## Device Optimization

### Screen Sizes and Orientations
```dart
// Responsive design
MediaQuery.of(context).size.width
MediaQuery.of(context).size.height

// Orientation handling
OrientationBuilder(
  builder: (context, orientation) {
    if (orientation == Orientation.portrait) {
      return PortraitWidget();
    } else {
      return LandscapeWidget();
    }
  },
)

// Device-specific layouts
LayoutBuilder(
  builder: (context, constraints) {
    if (constraints.maxWidth > 600) {
      return TabletLayout();
    } else {
      return PhoneLayout();
    }
  },
)
```

### Battery Optimization
```dart
// Background processing
Workmanager().initialize(callbackDispatcher);
Workmanager().registerPeriodicTask(
  "1",
  "background-task",
  frequency: Duration(hours: 1),
)

// Location updates
Location location = Location();
location.enableBackgroundMode(enable: true);
```

### Network State Management
```dart
// Check connectivity
var connectivityResult = await (Connectivity().checkConnectivity());

// Handle network changes
Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  if (result == ConnectivityResult.none) {
    // Handle offline mode
  } else {
    // Handle online mode
  }
});
```

## Testing on Mobile

### Device Testing
```dart
// Integration tests for mobile
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets('User can place order on mobile', (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());
    
    // Simulate mobile interactions
    await tester.tap(find.byIcon(Icons.restaurant));
    await tester.pumpAndSettle();
    
    // Test touch gestures
    await tester.drag(find.byType(ListView), Offset(0, -300));
    await tester.pumpAndSettle();
    
    // Verify mobile-specific behavior
    expect(find.text('Order Placed'), findsOneWidget);
  });
}
```

### Platform-Specific Testing
```dart
// Test on specific platforms
if (Platform.isIOS) {
  // iOS-specific tests
} else if (Platform.isAndroid) {
  // Android-specific tests
}
```

## App Store Optimization

### Metadata
- **App Name**: Clear, searchable name
- **Description**: Compelling feature description
- **Keywords**: Relevant search terms
- **Screenshots**: High-quality, descriptive screenshots
- **Promotional Text**: Highlight key features

### Ratings and Reviews
```dart
// In-app review requests
if (await InAppReview.isAvailable()) {
  InAppReview.requestReview();
}
```

### Localization
```dart
// App Store localization
// Create localized metadata for different languages
```

## Mobile Security

### Data Protection
```dart
// Secure storage
final storage = FlutterSecureStorage();
await storage.write(key: 'token', value: 'secure_token');

// Biometric authentication
final localAuth = LocalAuthentication();
final didAuthenticate = await localAuth.authenticate(
  localizedReason: 'Please authenticate to proceed',
);
```

### Privacy Compliance
```dart
// Privacy manifest
// ios/Runner/PrivacyInfo.xcprivacy
```

## Performance Monitoring

### Mobile-Specific Metrics
- **App Launch Time**: Cold/warm start times
- **Frame Rate**: Smooth scrolling and animations
- **Battery Usage**: Power consumption
- **Network Usage**: Data consumption
- **Crash Rate**: Stability metrics

### Monitoring Tools
```dart
// Firebase Performance Monitoring
FirebasePerformance.instance.newTrace("order_placement").start();

// Custom metrics
trace.incrementMetric("items_added", 1);
trace.stop();
```

## Best Practices

### Mobile-First Design
- **Touch Targets**: Minimum 44x44 pixels
- **Navigation**: Thumb-friendly navigation
- **Content**: Scannable content
- **Loading**: Optimistic UI and loading states

### Platform Guidelines
- **iOS**: Follow Apple's Human Interface Guidelines
- **Android**: Follow Material Design Guidelines
- **Cross-platform**: Maintain platform consistency

### User Experience
- **Onboarding**: Simple, intuitive onboarding
- **Feedback**: Immediate feedback for actions
- **Accessibility**: Support for accessibility features
- **Offline**: Graceful offline handling

This mobile development documentation will be updated regularly to reflect new mobile development practices, platform updates, and requirements.