# CI/CD Pipeline

This document describes the continuous integration and continuous deployment pipeline for the FoodDeli application.

## Overview

The FoodDeli project uses automated CI/CD pipelines to ensure code quality, automate testing, and streamline deployment processes. We support both GitHub Actions and GitLab CI/CD pipelines.

## GitHub Actions

### Workflow Files
The GitHub Actions workflows are located in `.github/workflows/` directory.

### Main Workflow
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

## GitLab CI/CD

### Configuration File
The GitLab CI/CD configuration is defined in `.gitlab-ci.yml`.

### Pipeline Stages
```yaml
stages:
  - build
  - test
  - deploy

variables:
  FLUTTER_VERSION: "3.4.0"

before_script:
  - apt update
  - apt install -y curl git unzip
  - curl -L https://github.com/flutter/flutter/archive/$FLUTTER_VERSION.tar.gz | tar xz -C /opt
  - export PATH="$PATH:/opt/flutter/bin"
  - flutter doctor

build:
  stage: build
  script:
    - flutter pub get
    - flutter build apk
  artifacts:
    paths:
      - build/app/outputs/flutter-apk/

test:
  stage: test
  script:
    - flutter pub get
    - flutter test
    - flutter analyze

deploy_staging:
  stage: deploy
  script:
    - echo "Deploying to staging environment"
  only:
    - develop

deploy_production:
  stage: deploy
  script:
    - echo "Deploying to production environment"
  only:
    - main
```

## Codemagic Integration

### Configuration
The project is also configured for Codemagic CI/CD with the following workflow:

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

## Testing Pipeline

### Unit Tests
- Run on every push and pull request
- Coverage threshold: 80%
- Results reported in PR comments

### Integration Tests
- Run on develop and main branches
- Cross-platform compatibility checks
- Performance benchmarks

### Widget Tests
- Run on every push
- UI component validation
- Screenshot testing for visual regression

## Deployment Pipeline

### Staging Deployment
- Automatic deployment from develop branch
- Limited user access for testing
- Monitoring and alerting enabled

### Production Deployment
- Manual approval required
- Gradual rollout to users
- Rollback capability

## Security Scanning

### Dependency Scanning
- Automated vulnerability detection
- Regular dependency updates
- Security advisories monitoring

### Code Scanning
- Static code analysis
- Security best practices enforcement
- Automated security testing

## Monitoring and Notifications

### Slack Integration
- Build status notifications
- Deployment announcements
- Critical issue alerts

### Email Notifications
- Build failures
- Deployment success/failure
- Security alerts

## Environment Management

### Development
- Feature branch deployments
- Local development environment
- Automated testing

### Staging
- Pre-production environment
- User acceptance testing
- Performance testing

### Production
- Live application environment
- Monitoring and alerting
- Disaster recovery

## Best Practices

### Pipeline Optimization
- Parallel job execution
- Caching dependencies
- Artifact storage optimization

### Security
- Secrets management
- Access control
- Audit logging

### Reliability
- Retry mechanisms
- Timeout handling
- Error recovery

This CI/CD documentation will be updated as the pipeline evolves and new requirements are identified.