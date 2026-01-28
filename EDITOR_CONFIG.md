# Editor Configuration

This document describes the editor configuration used in the FoodDeli project.

## Overview

The FoodDeli project uses EditorConfig to maintain consistent coding styles across different editors and IDEs. This ensures that all developers have a consistent experience regardless of their preferred development environment.

## EditorConfig File

### .editorconfig
The project includes an `.editorconfig` file in the root directory with the following configuration:

```ini
# EditorConfig is awesome: https://EditorConfig.org

# top-most EditorConfig file
root = true

# Default settings for all files
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# 4 space indentation for Makefiles
[Makefile]
indent_style = tab

# Indentation override for all JS under lib directory
[lib/**.js]
indent_style = space
indent_size = 2

# Matches the exact files package.json and .travis.yml
[{package.json,.travis.yml}]
indent_style = space
indent_size = 2

# Dart files
[*.dart]
indent_style = space
indent_size = 2
max_line_length = 80

# YAML files
[*.yml]
indent_style = space
indent_size = 2

# JSON files
[*.json]
indent_style = space
indent_size = 2

# Markdown files
[*.md]
trim_trailing_whitespace = false

# Configuration files
[*.config.js]
indent_style = space
indent_size = 2

# Test files
[*test*.dart]
indent_style = space
indent_size = 2

# Documentation files
[docs/**.md]
trim_trailing_whitespace = false
```

## Supported Editors

### Native Support
The following editors have native EditorConfig support:
- IntelliJ IDEA
- WebStorm
- Android Studio
- Xcode (with plugin)
- Visual Studio
- Atom
- Sublime Text (with plugin)

### Plugin Support
The following editors require plugins for EditorConfig support:
- Visual Studio Code (EditorConfig for VS Code)
- Vim (editorconfig-vim)
- Emacs (editorconfig-emacs)
- Notepad++ (EditorConfig plugin)

## Configuration Details

### Character Encoding
- **charset**: UTF-8 for all files

### Line Endings
- **end_of_line**: LF (Unix-style line endings)
- Consistent across all platforms

### Whitespace Handling
- **insert_final_newline**: Always insert final newline
- **trim_trailing_whitespace**: Remove trailing whitespace (except Markdown)

### Indentation
- **indent_style**: Space
- **indent_size**: 2 spaces for most files
- Tab indentation for Makefiles

### File-specific Settings
- **Dart files**: 80 character line limit
- **Markdown files**: No trailing whitespace trimming
- **Test files**: Consistent indentation

## Benefits

### Consistency
- Uniform code style across the project
- Eliminates style-related merge conflicts
- Reduces code review noise

### Developer Experience
- No need to configure individual editors
- Consistent experience across different IDEs
- Automatic enforcement of style guidelines

### Maintenance
- Single source of truth for style settings
- Easy to update and maintain
- Version-controlled with the project

## Customization

### Project-specific Rules
Additional rules can be added for specific file types:
```ini
# Flutter specific files
[*.dart]
max_line_length = 80
```

### Directory-specific Rules
Rules can be applied to specific directories:
```ini
# Documentation directory
[docs/**]
trim_trailing_whitespace = false
```

## Integration

### IDE Setup
Most modern IDEs will automatically detect and apply EditorConfig settings. For editors that require plugins, installation instructions can be found at https://editorconfig.org/#download.

### Validation
EditorConfig settings can be validated using command-line tools:
```bash
# Install editorconfig-checker
npm install -g editorconfig-checker

# Validate files
editorconfig-checker
```

## Best Practices

### Version Control
- Always include `.editorconfig` in version control
- Place in the root directory
- Set `root = true` to prevent inheritance

### File Organization
- Group related settings together
- Use comments to explain complex rules
- Keep the file organized and readable

### Updates
- Review and update settings periodically
- Communicate changes to the team
- Test settings with various editors

This EditorConfig documentation will be updated as new file types are added and settings are refined.