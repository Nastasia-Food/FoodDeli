# Internationalization

This document provides comprehensive guidance for internationalizing the FoodDeli food delivery application.

## Overview

FoodDeli supports multiple languages and regions to provide a global user experience. This document covers the internationalization (i18n) and localization (l10n) implementation, supported languages, and best practices.

## Supported Languages

### Current Languages
1. **English** (en) - Default language
2. **Arabic** (ar) - Right-to-left support
3. **Bengali** (bn) - Indian language support
4. **French** (fr) - European language support
5. **German** (de) - European language support

### Planned Languages
1. **Spanish** (es) - Latin American support
2. **Chinese** (zh) - Simplified Chinese
3. **Japanese** (ja) - East Asian support
4. **Russian** (ru) - Cyrillic support
5. **Hindi** (hi) - Indian language support

## Implementation

### Language Files
Language files are located in `lib/localization/` directory:

```
lib/localization/
├── language.dart          # Language management
├── english.dart           # English translations
├── arabic.dart            # Arabic translations
├── bangla.dart           # Bengali translations
├── french.dart           # French translations
└── german.dart           # German translations
```

### Language Structure
```dart
// lib/localization/english.dart
class English {
  static const Map<String, String> translations = {
    'app_name': 'FoodDeli',
    'welcome_message': 'Welcome to FoodDeli',
    'order_food': 'Order Food',
    'track_order': 'Track Order',
    'my_profile': 'My Profile',
    'settings': 'Settings',
    'language': 'Language',
    'notifications': 'Notifications',
    'help': 'Help',
    'logout': 'Logout',
    // ... more translations
  };
}
```

### Language Management
```dart
// lib/localization/language.dart
class Language {
  final String languageCode;
  final String languageName;
  final Map<String, String> translations;
  
  Language({
    required this.languageCode,
    required this.languageName,
    required this.translations,
  });
  
  static List<Language> get supportedLanguages => [
    Language(
      languageCode: 'en',
      languageName: 'English',
      translations: English.translations,
    ),
    Language(
      languageCode: 'ar',
      languageName: 'العربية',
      translations: Arabic.translations,
    ),
    // ... other languages
  ];
}
```

## Right-to-Left Support

### RTL Implementation
```dart
// lib/main.dart
MaterialApp(
  locale: Locale(selectedLanguage),
  supportedLocales: [
    Locale('en', ''),
    Locale('ar', ''),
    Locale('bn', ''),
    Locale('fr', ''),
    Locale('de', ''),
  ],
  theme: ThemeData(
    // Apply RTL theme when needed
  ),
  builder: (context, child) {
    if (selectedLanguage == 'ar') {
      return Directionality(
        textDirection: TextDirection.rtl,
        child: child!,
      );
    }
    return child!;
  },
)
```

### RTL UI Considerations
- **Text Alignment**: Right-aligned for RTL languages
- **Icon Placement**: Mirrored icons for RTL
- **Navigation**: Right-aligned navigation elements
- **Forms**: Right-aligned input fields

## Currency Support

### Multi-Currency Implementation
```dart
// lib/util/currency.dart
class Currency {
  final String code;
  final String symbol;
  final int decimalPlaces;
  
  Currency({
    required this.code,
    required this.symbol,
    required this.decimalPlaces,
  });
  
  static List<Currency> get supportedCurrencies => [
    Currency(code: 'USD', symbol: '\$', decimalPlaces: 2),
    Currency(code: 'EUR', symbol: '€', decimalPlaces: 2),
    Currency(code: 'GBP', symbol: '£', decimalPlaces: 2),
    Currency(code: 'SAR', symbol: '﷼', decimalPlaces: 2),
    Currency(code: 'BDT', symbol: '৳', decimalPlaces: 2),
  ];
}
```

### Currency Formatting
```dart
// Format currency based on user preference
NumberFormat currencyFormatter = NumberFormat.currency(
  locale: userLocale,
  symbol: selectedCurrency.symbol,
  decimalDigits: selectedCurrency.decimalPlaces,
);

String formattedAmount = currencyFormatter.format(amount);
```

## Date and Time Localization

### Date Formatting
```dart
// lib/util/date_formatter.dart
class DateFormatter {
  static String formatDateTime(DateTime date, String locale) {
    return DateFormat.yMMMMd(locale).format(date);
  }
  
  static String formatTime(DateTime date, String locale) {
    return DateFormat.jm(locale).format(date);
  }
  
  static String formatRelativeTime(DateTime date, String locale) {
    final now = DateTime.now();
    final difference = now.difference(date);
    
    if (difference.inMinutes < 1) {
      return Intl.message('Just now', locale: locale);
    } else if (difference.inMinutes < 60) {
      return Intl.message(
        '${difference.inMinutes} minutes ago',
        locale: locale,
      );
    }
    // ... more relative time formats
  }
}
```

## Number Formatting

### Number Localization
```dart
// Format numbers according to locale
NumberFormat numberFormatter = NumberFormat.decimalPattern(userLocale);
String formattedNumber = numberFormatter.format(123456.789);

// Format percentages
NumberFormat percentFormatter = NumberFormat.percentPattern(userLocale);
String formattedPercent = percentFormatter.format(0.75);
```

## Adding New Languages

### Steps to Add a Language
1. **Create Language File**
   ```dart
   // lib/localization/spanish.dart
   class Spanish {
     static const Map<String, String> translations = {
       'app_name': 'FoodDeli',
       'welcome_message': 'Bienvenido a FoodDeli',
       // ... more translations
     };
   }
   ```

2. **Update Language Management**
   ```dart
   // lib/localization/language.dart
   static List<Language> get supportedLanguages => [
     // ... existing languages
     Language(
       languageCode: 'es',
       languageName: 'Español',
       translations: Spanish.translations,
     ),
   ];
   ```

3. **Update UI Components**
   ```dart
   // Ensure all text uses translation keys
   Text(translate('welcome_message'))
   ```

4. **Test Localization**
   - Test text direction
   - Verify number formatting
   - Check date/time formatting
   - Validate all UI elements

## Translation Management

### Translation Keys
```dart
// Consistent key naming
'user.profile.name'        // User profile name
'order.status.pending'      // Order status pending
'payment.method.credit_card' // Payment method credit card
'error.network.timeout'     // Network timeout error
```

### Pluralization
```dart
// Handle plural forms
String getItemsText(int count) {
  switch (count) {
    case 0:
      return translate('no_items');
    case 1:
      return translate('one_item');
    default:
      return translate('multiple_items', args: [count.toString()]);
  }
}
```

### Gender and Case Sensitivity
```dart
// Handle gender-specific translations
String getWelcomeMessage(String gender) {
  switch (gender) {
    case 'male':
      return translate('welcome_male');
    case 'female':
      return translate('welcome_female');
    default:
      return translate('welcome_neutral');
  }
}
```

## Testing Internationalization

### Language Testing
```dart
// Test all supported languages
void main() {
  group('Internationalization', () {
    test('English translations', () {
      final english = Language.supportedLanguages
          .firstWhere((lang) => lang.languageCode == 'en');
      expect(english.translations['app_name'], 'FoodDeli');
    });
    
    test('Arabic RTL support', () {
      final arabic = Language.supportedLanguages
          .firstWhere((lang) => lang.languageCode == 'ar');
      expect(arabic.translations['app_name'], 'فود ديلي');
    });
  });
}
```

### UI Testing
```dart
// Test UI with different languages
testWidgets('RTL layout test', (WidgetTester tester) async {
  await tester.pumpWidget(MyApp(locale: Locale('ar')));
  
  // Verify RTL layout
  final finder = find.byType(RTLWidget);
  expect(finder, findsOneWidget);
});
```

## Best Practices

### Translation Quality
- **Consistency**: Use consistent terminology
- **Context**: Provide context for translators
- **Cultural Sensitivity**: Consider cultural differences
- **Review**: Regular translation reviews

### Performance
- **Caching**: Cache translations for performance
- **Lazy Loading**: Load translations on demand
- **Memory**: Efficient memory usage for translations

### Maintenance
- **Version Control**: Track translation changes
- **Automation**: Automate translation updates
- **Fallback**: Graceful fallback to default language

## Tools and Resources

### Translation Tools
- **Crowdin**: Professional translation management
- **Transifex**: Localization platform
- **Google Translate**: Initial translations
- **DeepL**: High-quality translations

### Validation Tools
- **Spell Check**: Language-specific spell checking
- **Grammar Check**: Grammar validation
- **Cultural Review**: Cultural appropriateness review

## Future Improvements

### Machine Learning
- **Smart Translation**: AI-powered translations
- **Context Awareness**: Context-sensitive translations
- **Real-time Translation**: In-app translation

### Community Involvement
- **Crowdsourcing**: Community translation contributions
- **Feedback Loop**: User feedback on translations
- **Recognition**: Acknowledge translation contributors

This internationalization documentation will be updated regularly to reflect new languages, translation improvements, and localization best practices.