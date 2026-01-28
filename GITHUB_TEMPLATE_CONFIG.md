# GitHub Template Configuration

This document describes the GitHub issue template configuration used in the FoodDeli project.

## Overview

The FoodDeli project uses GitHub issue templates to standardize the reporting of bugs, feature requests, and other issues. This configuration helps maintain consistency and ensures that contributors provide the necessary information.

## Configuration File

### config.yml
The project includes a `config.yml` file in the `.github/ISSUE_TEMPLATE` directory with the following configuration:

```yaml
blank_issues_enabled: false
contact_links:
  - name: FoodDeli Support
    url: https://github.com/Nastasia-Food/FoodDeli/discussions
    about: Please ask and answer questions here.
  - name: FoodDeli Documentation
    url: https://github.com/Nastasia-Food/FoodDeli/tree/main/docs
    about: Please check our documentation for help.
  - name: Email Support
    url: mailto:support@rechain.network
    about: Please send us an email for private support.
```

## Template Types

### Bug Report
- **File**: `bug_report.md`
- **Purpose**: Report software bugs and issues
- **Labels**: `bug`, `triage`
- **Fields**:
  - Bug description
  - Steps to reproduce
  - Expected behavior
  - Screenshots
  - Device information

### Feature Request
- **File**: `feature_request.md`
- **Purpose**: Suggest new features or improvements
- **Labels**: `enhancement`, `feature`
- **Fields**:
  - Problem description
  - Proposed solution
  - Alternative solutions
  - Additional context

### Documentation
- **File**: `documentation.md`
- **Purpose**: Report documentation issues or suggest improvements
- **Labels**: `documentation`, `content`
- **Fields**:
  - Documentation issue description
  - Related document
  - Clarification needed
  - Additional context

### Question
- **File**: `question.md`
- **Purpose**: Ask questions about the project
- **Labels**: `question`, `support`
- **Fields**:
  - Question description
  - Related project area
  - Documentation review status
  - Additional context

## Configuration Options

### Blank Issues
- **blank_issues_enabled**: `false`
- Prevents users from creating blank issues
- Ensures all issues follow a template

### Contact Links
- **Support**: GitHub Discussions link
- **Documentation**: Project documentation link
- **Email**: Private support email

## Benefits

### Consistency
- Standardized issue reporting
- Consistent information collection
- Easier issue triage and management

### Quality
- Improved issue quality
- Reduced back-and-forth for information
- Better understanding of reported issues

### Community
- Clear expectations for contributors
- Easier onboarding for new contributors
- Professional issue management

## Customization

### Adding New Templates
To add a new template:
1. Create a new `.md` file in `.github/ISSUE_TEMPLATE/`
2. Add the YAML front matter with metadata
3. Define the template structure
4. Update the configuration if needed

### Modifying Existing Templates
To modify existing templates:
1. Edit the template file directly
2. Update the YAML front matter if needed
3. Test the template in the GitHub UI
4. Communicate changes to the team

## Best Practices

### Template Design
- Keep templates focused and specific
- Use clear, concise language
- Include only necessary fields
- Provide examples where helpful

### Field Organization
- Group related fields together
- Place most important fields first
- Use appropriate input types
- Include helpful descriptions

### Labels and Assignees
- Use consistent label naming
- Assign appropriate default labels
- Set default assignees when applicable
- Consider label hierarchy and grouping

## Integration

### GitHub Setup
GitHub automatically detects and applies issue templates from the `.github/ISSUE_TEMPLATE/` directory.

### Validation
Templates can be validated by creating test issues in the repository.

## Maintenance

### Regular Updates
- Review templates periodically
- Update based on common issues
- Add new templates as needed
- Remove outdated templates

### Community Feedback
- Monitor template usage
- Collect feedback from contributors
- Adjust templates based on feedback
- Communicate changes to the community

This GitHub template configuration documentation will be updated as new templates are added and existing ones are refined.