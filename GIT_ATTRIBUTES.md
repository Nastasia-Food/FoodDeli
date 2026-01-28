# Git Attributes

This document describes the Git attributes configuration used in the FoodDeli project.

## Overview

The FoodDeli project uses a `.gitattributes` file to control how Git handles line endings, file merging, and other file-specific behaviors. This ensures consistent behavior across different operating systems and development environments.

## Git Attributes File

### .gitattributes
The project includes a `.gitattributes` file in the root directory with the following configuration:

```gitattributes
# Auto detect text files and perform LF normalization
* text=auto

# Custom for Visual Studio
*.cs     diff=csharp
*.sln    merge=union
*.csproj merge=union
*.vbproj merge=union
*.fsproj merge=union
*.dbproj merge=union

# Standard to msysgit is recursing submodules
.sln     merge=binary

# Flutter/Dart specific
*.dart text=auto
*.yaml text=auto
*.yml text=auto
*.json text=auto
*.md text=auto
*.html text=auto
*.css text=auto
*.js text=auto
*.ts text=auto
*.xml text=auto
*.plist text=auto

# Binary files
*.png binary
*.jpg binary
*.jpeg binary
*.gif binary
*.ico binary
*.bmp binary
*.tiff binary
*.webp binary
*.pdf binary
*.zip binary
*.tar binary
*.gz binary
*.7z binary
*.exe binary
*.dll binary
*.so binary
*.dylib binary
*.app binary
*.apk binary
*.ipa binary
*.keystore binary

# iOS specific
*.xcworkspace binary
*.xcodeproj binary
*.storyboard binary
*.xib binary
*.nib binary
*.mobileprovision binary

# Android specific
*.apk binary
*.aab binary
*.jks binary
*.keystore binary
*.gradle binary

# Generated files
*.g.dart text=auto
*.freezed.dart text=auto
*.mocks.dart text=auto
lib/generated_plugin_registrant.dart text=auto
ios/Runner/GeneratedPluginRegistrant.* text=auto

# Documentation
docs/**/*.md text=auto
*.md text=auto

# Configuration
*.env binary
*.env.* binary
*.secret binary
*.key binary
```

## Line Ending Handling

### Text Files
- **text=auto**: Automatically normalize line endings to LF
- Consistent behavior across Windows, macOS, and Linux
- Prevents line ending conflicts in diffs

### Binary Files
- **binary**: Prevents Git from modifying binary files
- Ensures integrity of images, executables, and archives
- Improves performance for large binary files

## Merge Strategies

### Union Merge
- **merge=union**: Combines changes from both branches
- Useful for project files that can be merged automatically
- Applied to Visual Studio project files

### Binary Merge
- **merge=binary**: Treats files as binary during merge
- Prevents corruption of binary files
- Applied to compiled artifacts

## Diff Strategies

### Custom Diff
- **diff=csharp**: Uses C# specific diff for .cs files
- Provides better diff output for specific file types
- Can be extended for other languages

## File Type Handling

### Text Files
- Source code files
- Configuration files
- Documentation files
- Automatically normalized

### Binary Files
- Images and media
- Compiled artifacts
- Archives and packages
- No normalization applied

## Platform-specific Handling

### Cross-platform Compatibility
- Consistent line ending handling
- Proper binary file detection
- Platform-specific file type recognition

### Generated Files
- Proper handling of code-generated files
- Flutter-specific generated files
- IDE-specific generated files

## Benefits

### Consistency
- Uniform handling of files across platforms
- Eliminates line ending conflicts
- Consistent merge behavior

### Performance
- Proper binary file handling
- Reduced repository size
- Faster clone and fetch operations

### Integrity
- Protection of binary files from corruption
- Proper handling of generated files
- Consistent file type detection

## Customization

### Project-specific Rules
Additional rules can be added for specific file types:
```gitattributes
# Custom file types
*.custom text=auto
*.data binary
```

### Directory-specific Rules
Rules can be applied to specific directories:
```gitattributes
# Documentation directory
docs/** text=auto
```

## Integration

### Git Setup
Git automatically detects and applies `.gitattributes` settings. No additional configuration is required.

### Validation
Git attributes can be validated using command-line tools:
```bash
# Check attributes for a file
git check-attr -a filename

# List all attributes
git check-attr --all -- filename
```

## Best Practices

### Version Control
- Always include `.gitattributes` in version control
- Place in the root directory
- Keep it updated with project needs

### File Organization
- Group related settings together
- Use comments to explain complex rules
- Keep the file organized and readable

### Updates
- Review and update settings periodically
- Communicate changes to the team
- Test settings with various file types

## Common Issues

### Line Ending Conflicts
- Ensure `text=auto` is set for text files
- Check for mixed line endings in files
- Use `git add --renormalize` to fix existing files

### Binary File Corruption
- Ensure binary files are marked as `binary`
- Check for text conversion of binary files
- Use `git diff --no-index` to compare binary files

### Merge Conflicts
- Use appropriate merge strategies for file types
- Check for union merge on project files
- Validate merge results for binary files

This Git attributes documentation will be updated as new file types are added and settings are refined.