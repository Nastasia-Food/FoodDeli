# GitHub Workflows

This document describes the GitHub Actions workflows used in the FoodDeli project.

## Overview

The FoodDeli project uses GitHub Actions for continuous integration and continuous deployment. These workflows automate testing, building, and deployment processes.

## Main Workflow

### File: `.github/workflows/flutter-ci.yml`

```yaml
name: Flutter CI

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-java@v3
      with:
        java-version: '12.x'
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.4.0'
    - run: flutter pub get
    - run: flutter test
    - run: flutter analyze

  build:
    needs: test
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: actions/setup-java@v3
      with:
        java-version: '12.x'
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.4.0'
    - run: flutter pub get
    - run: flutter build apk --release
    - uses: actions/upload-artifact@v3
      with:
        name: release-apk
        path: build/app/outputs/flutter-apk/app-release.apk
```

## Code Quality Workflow

### File: `.github/workflows/code-quality.yml`

```yaml
name: Code Quality

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  lint:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.4.0'
    - run: flutter pub get
    - run: flutter analyze
    - run: flutter format --set-exit-if-changed .

  test-coverage:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - uses: subosito/flutter-action@v2
      with:
        flutter-version: '3.4.0'
    - run: flutter pub get
    - run: flutter test --coverage
    - uses: codecov/codecov-action@v3
      with:
        file: coverage/lcov.info
```

## Deployment Workflow

### File: `.github/workflows/deploy.yml`

```yaml
name: Deploy

on:
  push:
    branches: [ main ]

jobs:
  deploy-staging:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
    - uses: actions/checkout@v3
    - name: Deploy to staging
      run: |
        echo "Deploying to staging environment"
        # Add deployment commands here

  create-release:
    runs-on: ubuntu-latest
    needs: deploy-staging
    steps:
    - uses: actions/checkout@v3
    - uses: actions/create-release@v1
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
      with:
        tag_name: ${{ github.ref }}
        release_name: Release ${{ github.ref }}
        draft: false
        prerelease: false
```

## Security Scanning Workflow

### File: `.github/workflows/security.yml`

```yaml
name: Security Scan

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]
  schedule:
    - cron: '0 0 * * 1'  # Weekly on Sundays

jobs:
  dependency-review:
    runs-on: ubuntu-latest
    steps:
    - name: 'Dependency Review'
      uses: actions/dependency-review-action@v3

  codeql:
    runs-on: ubuntu-latest
    steps:
    - name: Checkout repository
      uses: actions/checkout@v3
    - name: Initialize CodeQL
      uses: github/codeql-action/init@v2
      with:
        languages: javascript
    - name: Autobuild
      uses: github/codeql-action/autobuild@v2
    - name: Perform CodeQL Analysis
      uses: github/codeql-action/analyze@v2
```

## Documentation Workflow

### File: `.github/workflows/docs.yml`

```yaml
name: Documentation

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main ]

jobs:
  validate-docs:
    runs-on: ubuntu-latest
    steps:
    - uses: actions/checkout@v3
    - name: Check markdown links
      uses: gaurav-nelson/github-action-markdown-link-check@v1
    - name: Lint markdown files
      uses: avto-dev/markdown-lint@v1
```

## Workflow Triggers

### Push Events
- Triggered on pushes to main and develop branches
- Run full test suite and build processes
- Update documentation automatically

### Pull Request Events
- Triggered on pull requests to main branch
- Run code quality checks
- Provide feedback before merge

### Scheduled Events
- Weekly security scans
- Periodic dependency updates
- Performance benchmarking

## Environment Variables

### Secrets Required
- `FIREBASE_TOKEN` - For Firebase deployment
- `CODECOV_TOKEN` - For code coverage reporting
- `SLACK_WEBHOOK` - For notifications

### Variables
- `FLUTTER_VERSION` - Flutter SDK version
- `JAVA_VERSION` - Java version for Android builds

## Artifacts and Caching

### Cached Directories
- Flutter SDK
- Pub dependencies
- Gradle dependencies

### Artifacts Generated
- APK files for Android
- App bundles for Google Play
- IPA files for iOS (when available)

## Notifications

### Slack Integration
- Build success/failure notifications
- Deployment status updates
- Security alerts

### Email Notifications
- Critical build failures
- Security vulnerabilities
- Release announcements

## Custom Actions

### Reusable Workflows
- Flutter setup and testing
- Code signing for mobile apps
- Documentation generation

### Composite Actions
- Environment setup
- Code quality checks
- Deployment procedures

## Best Practices

### Workflow Design
- Keep workflows focused on single responsibilities
- Use matrix strategies for multi-platform testing
- Implement proper error handling

### Security
- Use secrets for sensitive information
- Limit permissions for GitHub actions
- Regular security audits

### Performance
- Cache dependencies to reduce build times
- Run jobs in parallel when possible
- Optimize artifact storage

This documentation will be updated as workflows evolve and new requirements are identified.