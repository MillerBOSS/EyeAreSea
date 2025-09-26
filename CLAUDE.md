# CLAUDE.md - EyeAreSea Project Instructions

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 🚨 **CRITICAL: GitHub Identity Requirements**

**MANDATORY CHECKS BEFORE ANY GITHUB OPERATIONS:**

1. **ALWAYS verify GitHub identity is MillerBOSS before creating issues, PRs, or commits**
2. **Run these commands BEFORE any GitHub operation:**
   ```bash
   # Verify correct account is active
   gh auth status

   # Confirm user identity
   gh api user
   ```
3. **ONLY MillerBOSS identity is allowed - NEVER use personal accounts**
4. **If wrong account is active, switch immediately:**
   ```bash
   gh auth switch --user MillerBOSS
   ```

**ANONYMITY PROTECTION:**
- Repository operations must maintain complete anonymity
- No personal developer information should appear in any GitHub activity
- All commits, issues, and PRs must be attributed to MillerBOSS only

**PREVENTION MEASURES:**
Future Claude Code sessions MUST follow these identity verification steps or risk creating anonymity breaches that require complete cleanup and recreation of GitHub content.

## Project Overview

Textual is a macOS IRC client written in Objective-C with some Swift components. Originally forked from LimeChat in 2010, it's developed by Codeux Software. The project is no longer being actively maintained as of the README notice.

**EyeAreSea** is our fork focused on:
- macOS 26 (Tahoe) compatibility
- Modern API adoption (Network.framework, CryptoKit)
- Liquid Glass design language integration
- Enhanced accessibility and UX

## Build System

### Development Environment Setup
```bash
# Switch to development environment (no Apple Developer cert required)
./dev-setup.sh dev

# Build with Xcode
xcodebuild -workspace Textual.xcworkspace -scheme "Textual (Standard Release)" -configuration Release clean build
```

### Key Build Requirements
- **Workspace**: `Textual.xcworkspace` (not individual .xcodeproj files)
- **Primary Scheme**: "Textual (Standard Release)"
- **Code Signing**: Uses `Configurations/Build/Code Signing Identity.xcconfig`
- **License Manager**: Set `TEXTUAL_BUILT_WITH_LICENSE_MANAGER=0` in build config

## Architecture

### Core Components
- **Main Application**: `Sources/App/` - Primary Textual application
- **XPC Services**: IRC Remote Connection Manager, Historic Log File Manager, Inline Content Loader
- **Extensions**: 6 plugin extensions (Caffeine, Chat Filter, Smiley Converter, etc.)
- **Frameworks**: CocoaExtensions, EncryptionKit, AutoHyperlinks

### Key Controllers
- **TXMasterController**: Central application controller
- **IRCClient**: Core IRC client functionality
- **TXAppearance**: UI appearance and theming

## Current Issues & Priorities

### Critical Issues
- **Framework Embedding**: Broken across project (Issue #13)
- **SSL/TLS Modernization**: Deprecated APIs need Network.framework migration (Issue #14)
- **119 Build Warnings**: Need systematic resolution for macOS 26 (Issue #15)

### Development Roadmap
- **Phase 1 (Weeks 1-2)**: Foundation Stability (Issue #21)
- **Phase 2 (Weeks 3-10)**: API Modernization (Issue #18)
- **Phase 3 (Weeks 11-17)**: UX & Distribution Prep (Issues #16, #17)
- **Phase 4 (Weeks 18-20)**: Liquid Glass Integration (Issue #20)

## 📚 **Additional Documentation**

Complete project documentation is in `.claude/docs/`:
- **BUILD-AND-TEST-GUIDE.md** - Complete build procedures
- **MODERNIZATION-ROADMAP.md** - 4-phase macOS 26 plan
- **XCODE-PROJECT-AUDIT.md** - Framework embedding analysis
- **CRITICAL-ISSUES.md** - Known connectivity issues

**For complete instructions**: See `.claude/CLAUDE.md` (full 6000+ token version)