# Build Schemes Reference Guide

**Complete breakdown of all available build schemes in Textual.xcworkspace**

## 📋 **Main Application Schemes**

### **Textual (Standard Release)** 📱
**Purpose**: Primary development and distribution build
- **Configuration**: Release
- **Code Signing**: Uses current identity settings
- **Sandboxing**: Enabled
- **License Manager**: Configurable via feature flags
- **Deployment Target**: macOS 11.0+
- **Architectures**: Universal (arm64 + x86_64)
- **Use Case**: Main development testing, distribution builds

### **Textual (Debug)** 🔧
**Purpose**: Development debugging with full symbols
- **Configuration**: Debug
- **Code Signing**: Uses current identity settings
- **Optimization**: None (debugging enabled)
- **Symbols**: Full debug symbols included
- **Assertions**: Enabled
- **Deployment Target**: macOS 11.0+
- **Use Case**: Active development, debugging, step-through debugging

### **Textual (Standard Release Sandboxed)** 🔒
**Purpose**: Fully sandboxed release build
- **Configuration**: Release with enhanced sandboxing
- **Sandboxing**: Maximum security restrictions
- **Entitlements**: Full sandbox entitlements
- **Use Case**: Testing sandbox compatibility, security validation

### **Textual (App Store)** 🏪
**Purpose**: Mac App Store distribution
- **Configuration**: Release
- **Code Signing**: Requires valid App Store certificates
- **Sandboxing**: App Store requirements enforced
- **Receipt Validation**: Enabled
- **Entitlements**: App Store compliant
- **Use Case**: App Store submission builds only

## 🔧 **Framework Schemes**

### **Build Frameworks** 🏗️
**Purpose**: Build all framework dependencies
- **Builds**: CocoaExtensions.framework, EncryptionKit.framework, AutoHyperlinks.framework
- **Output**: `.tmp/SharedBuildProducts-Frameworks/`
- **Dependencies**: Must run before main app builds
- **Use Case**: Dependency resolution, clean builds

### **CocoaExtensions.framework** 📚
**Purpose**: Shared utility framework
- **Contains**: Common macOS utilities and extensions
- **Dependencies**: System frameworks only
- **Used By**: Main app, XPC services, extensions
- **Architecture**: Universal binary

### **EncryptionKit.framework** 🔐
**Purpose**: Encryption and security functionality
- **Contains**: OTR, GPG, SSL utilities
- **Dependencies**: External crypto libraries
- **Used By**: Main app, IRC connection manager
- **Architecture**: Universal binary

### **AutoHyperlinks.framework** 🔗
**Purpose**: URL detection and link processing
- **Contains**: Text parsing, link detection
- **Dependencies**: CocoaExtensions.framework
- **Used By**: Main app (chat view)
- **Architecture**: Universal binary

## ⚙️ **XPC Service Schemes**

### **IRC Remote Connection Manager** 🌐
**Purpose**: Handles all IRC network connections
- **Type**: XPC Service
- **Sandboxing**: Limited network access
- **Dependencies**: CocoaExtensions.framework, EncryptionKit.framework
- **Communication**: XPC with main app
- **Deployment**: Embedded in main app bundle

### **Historic Log File Manager** 📄
**Purpose**: Chat log storage and retrieval
- **Type**: XPC Service
- **Sandboxing**: File access permissions
- **Dependencies**: CocoaExtensions.framework
- **Storage**: User's log directory
- **Deployment**: Embedded in main app bundle

### **Inline Content Loader** 🖼️
**Purpose**: Media and content loading
- **Type**: XPC Service
- **Sandboxing**: Network and temporary file access
- **Dependencies**: CocoaExtensions.framework
- **Use Case**: Image loading, media preview
- **Deployment**: Embedded in main app bundle

### **Inline Content Loader Core Media** 🎬
**Purpose**: Advanced media handling
- **Type**: XPC Service Extension
- **Capabilities**: Video, audio processing
- **Dependencies**: Inline Content Loader + Core Media frameworks
- **Use Case**: Rich media content
- **Deployment**: Embedded as extension

## 🔌 **Extension Schemes**

### **Caffeine Extension** ☕
**Purpose**: System sleep prevention
- **Type**: Textual Plugin Extension
- **Functionality**: Prevents system sleep during active IRC
- **Dependencies**: CocoaExtensions.framework
- **Deployment Target**: macOS 11.0+
- **Bundle**: Embedded in main app

### **Chat Filter Extension** 🧹
**Purpose**: Message filtering and processing
- **Type**: Textual Plugin Extension
- **Functionality**: Content filtering, spam detection
- **Dependencies**: CocoaExtensions.framework
- **Configuration**: User-configurable rules
- **Bundle**: Embedded in main app

### **Smiley Converter Extension** 😊
**Purpose**: Emoticon and emoji processing
- **Type**: Textual Plugin Extension
- **Functionality**: Text to emoji conversion
- **Dependencies**: CocoaExtensions.framework
- **Resources**: Emoji mapping tables
- **Bundle**: Embedded in main app

### **System Profiler Extension** 💻
**Purpose**: System information reporting
- **Type**: Textual Plugin Extension
- **Functionality**: Hardware/software info for IRC
- **Dependencies**: CocoaExtensions.framework
- **Permissions**: System information access
- **Bundle**: Embedded in main app

### **User Insights Extension** 📊
**Purpose**: User activity and statistics
- **Type**: Textual Plugin Extension
- **Functionality**: Usage analytics, insights
- **Dependencies**: CocoaExtensions.framework
- **Storage**: Local analytics data
- **Bundle**: Embedded in main app

### **ZNC Additions Extension** 🔧
**Purpose**: ZNC bouncer integration
- **Type**: Textual Plugin Extension
- **Functionality**: ZNC-specific commands and features
- **Dependencies**: CocoaExtensions.framework
- **Use Case**: Enhanced ZNC bouncer support
- **Bundle**: Embedded in main app

## 🎯 **Deployment Target Matrix**

| Scheme | Debug Target | Release Target | App Store Target |
|--------|-------------|----------------|------------------|
| Main App | macOS 11.0 | macOS 11.0 | macOS 11.0 |
| XPC Services | macOS 11.0 | macOS 11.0 | macOS 11.0 |
| Extensions | macOS 11.0 | macOS 11.0 | macOS 11.0 |
| Frameworks | macOS 11.0 | macOS 11.0 | macOS 11.0 |

## 🔨 **Build Dependencies**

```
Build Order:
1. Build Frameworks (builds all .framework dependencies)
2. XPC Services (depend on frameworks)
3. Extensions (depend on frameworks)
4. Main App (depends on frameworks, embeds XPC services and extensions)
```

## 💡 **Common Build Scenarios**

### **Development Workflow:**
1. `Build Frameworks` - Ensure dependencies are current
2. `Textual (Debug)` - Development build with debugging

### **Testing Workflow:**
1. `Build Frameworks`
2. `Textual (Standard Release)` - Release testing

### **Distribution Workflow:**
1. `Build Frameworks`
2. `Textual (App Store)` - For App Store submission

### **Clean Build Workflow:**
1. Clean all schemes
2. `Build Frameworks`
3. Target scheme (Debug/Release/App Store)

## ⚠️ **Known Issues by Scheme**

- **All Extensions**: Code signing warnings (expected in dev environment)
- **XPC Services**: Framework embedding issues (CocoaExtensions.framework path)
- **App Store**: Requires valid certificates and proper entitlements
- **Sandboxed**: May have additional permission dialogs