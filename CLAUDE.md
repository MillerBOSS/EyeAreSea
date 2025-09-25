# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Textual is a macOS IRC client written in Objective-C with some Swift components. Originally forked from LimeChat in 2010, it's developed by Codeux Software. The project is no longer being actively maintained as of the README notice.

## Build System and Commands

### Building the Application
- **Primary Build Target**: Use the "Standard Release" build scheme in Xcode
- **Workspace File**: `Textual.xcworkspace` (use this instead of individual .xcodeproj files)
- **Minimum Requirements**: Xcode 10.0+ on macOS High Sierra (Swift 4.2 requirement)

### Code Signing Configuration
- **CRITICAL**: Never modify code signing settings through Xcode UI
- Edit `Configurations/Build/Code Signing Identity.xcconfig` to configure code signing
- A valid code signing certificate is required (doesn't need to be Apple-issued)
- Turning off code signing is highly discouraged as features depend on sandboxing

### License Management
- Set `TEXTUAL_BUILT_WITH_LICENSE_MANAGER=0` in `Configurations/Build/Standard Release/Enabled Features.xcconfig` if building without a license key
- This disables trial mode licensing code at build time

### Submodules
The project uses Git submodules. When cloning:
```bash
git clone https://github.com/Codeux-Software/Textual.git
cd Textual
git submodule update --init --recursive
```

## Architecture

### Core Components
- **Main Application**: `Sources/App/` - Primary Textual application
- **XPC Services**: Modular services handling specific functionality:
  - Historic Log File Manager
  - IRC Remote Connection Manager
  - Inline Content Loader (with Core Media extension)

### Key Controllers
- **TXMasterController**: Central application controller
- **TXWindowController**: Window management
- **TXMenuController**: Menu system management
- **TXAppearance**: UI appearance and theming
- **IRCClient**: Core IRC client functionality
- **IRCWorld**: Global IRC state management

### File Organization
- `Sources/App/Classes/Controllers/`: Application-level controllers
- `Sources/App/Classes/Dialogs/`: UI dialogs and sheets
- `Sources/App/Classes/Headers/`: Public header files
- `Sources/App/Classes/Headers/Internal/`: Internal implementation headers
- `Sources/App/Classes/Headers/Private/`: Private API headers
- `Configurations/Build/`: Build configuration files (.xcconfig)

### Build Configuration System
The project uses an extensive .xcconfig system for build configuration:
- `Configurations/Build/Common/`: Shared configuration
- `Configurations/Build/Standard Release/`: Release build settings
- `Configurations/Build/Debug/`: Debug build settings
- Feature flags in `Enabled Features.xcconfig` control compilation of optional features

### Key Features (Configurable)
- Sandbox environment support (TEXTUAL_BUILT_INSIDE_SANDBOX)
- Advanced encryption (TEXTUAL_BUILT_WITH_ADVANCED_ENCRYPTION)
- License management (TEXTUAL_BUILT_WITH_LICENSE_MANAGER)
- Sparkle auto-updates (TEXTUAL_BUILT_WITH_SPARKLE_ENABLED)

## Plugin and Extension System
- Supports plugins in Objective-C & Swift
- Supports scripts in AppleScript and other languages
- CSS/HTML/JavaScript style customization
- Documentation available at help.codeux.com for writing plugins and scripts