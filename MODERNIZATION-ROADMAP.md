# EyeAreSea Modernization Roadmap

**Original Project**: Textual IRC Client by Codeux Software
**Fork Date**: 2025-09-26
**Target**: Modernize for macOS 26.0 compatibility
**Status**: 119 deprecation warnings need addressing

## 📋 **Project Background**

### **Original Textual Specifications:**
- **Last Supported**: macOS High Sierra (10.13) minimum
- **Xcode Requirement**: Xcode 10.0+ (Swift 4.2)
- **Development Status**: Active until Sept 2024, archived Sept 2025
- **Last Commits**: September 8, 2024 (recent deprecation fixes)
- **License**: BSD-style (allows forking with attribution)
- **Architecture**: Main app + XPC services + Extensions

### **Current EyeAreSea Status:**
- **Building On**: macOS 26.0 with Xcode 26.0.1
- **Compatibility Gap**: ~7+ major macOS versions
- **Core Functionality**: ✅ Works (connects to IRC, joins channels)
- **Technical Debt**: 119 deprecation warnings

## 🎯 **What This Process Is Called**

This is **"API Modernization"** or **"Platform Migration"** - updating legacy code to use current macOS APIs and removing deprecated functionality. In the Apple ecosystem, this is essential because:

1. **Deprecated APIs eventually break** in future macOS releases
2. **Security improvements** require modern secure coding practices
3. **Performance benefits** from newer frameworks
4. **App Store compliance** may require current APIs

## 🚨 **Critical Issues (Must Fix)**

### **Priority 1: SSL/TLS Networking (Complete Rewrite Required)**
```
IMPACT: 🔴 CRITICAL - Core IRC connectivity
DEADLINE: Before next major macOS release

Issues:
- All SSL* APIs deprecated since macOS 10.15 (Catalina)
- 40+ SSL function deprecations in GCDAsyncSocket.m
- Network.framework is replacement but requires significant rewrite

Files Affected:
- Sources/Shared/Library/External Libraries/Sockets/GCDAsyncSocket.m
- XPC Services/IRC Remote Connection Manager/Classes/IRC/IRCConnectionSocket.swift
- XPC Services/IRC Remote Connection Manager/Classes/IRC/IRCConnectionSocketNWF.swift
```

### **Priority 2: Data Security & Archiving**
```
IMPACT: 🟠 HIGH - Data persistence and security
DEADLINE: Next 6 months

Issues:
- NSArchiver/NSUnarchiver deprecated (insecure)
- Keychain APIs deprecated since macOS 10.10
- NSFilenamesPboardType deprecated

Files Affected:
- Multiple .m files using archivedDataWithRootObject:
- TDCServerPropertiesSheet.m (keychain operations)
- Interface Builder .xib files
```

### **Priority 3: Code Signing & Entitlements**
```
IMPACT: 🟠 HIGH - App security and functionality
DEADLINE: Before distribution

Issues:
- All extensions/XPC services show "Not signed" warnings
- 4 permission dialogs on launch (improper entitlements)
- Sandboxing not working correctly

Components Affected:
- Main app, 6 extensions, 3 XPC services
```

## 📊 **Modernization Phases**

### **Phase 1: Foundation Stability (Weeks 1-4)**
- [ ] **Fix License Manager**: Set `TEXTUAL_BUILT_WITH_LICENSE_MANAGER=0` (already needed)
- [ ] **Update Project Settings**: Xcode 26 recommendations
- [ ] **Swift Warnings**: Fix switch statement exhaustiveness
- [ ] **Code Signing**: Proper development certificates for all components

### **Phase 2: Critical API Updates (Weeks 5-12)**
- [ ] **SSL/TLS Migration**: Replace all SSL* with Network.framework
- [ ] **Secure Archiving**: Update to NSSecureCoding pattern
- [ ] **Keychain Modernization**: Replace deprecated SecKeychain APIs
- [ ] **Pasteboard Updates**: Modern drag-and-drop APIs

### **Phase 3: Platform Integration (Weeks 13-16)**
- [ ] **Remove Legacy OS Checks**: Clean up XRRunningOnOSX* functions
- [ ] **Interface Builder**: Update deprecated NSUnarchiveFromData transformers
- [ ] **Entitlements Review**: Proper sandboxing and permissions
- [ ] **Testing**: Comprehensive functionality testing

### **Phase 4: Polish & Branding (Weeks 17-20)**
- [ ] **Rename to EyeAreSea**: Update UI strings, bundle IDs, etc.
- [ ] **Documentation**: Update help files and about screens
- [ ] **Icon & Branding**: New visual identity
- [ ] **Final Testing**: Complete feature verification

## 🔧 **Development Environment Notes**

### **What `./dev-setup.sh dev` Does:**
1. **Copies** `Code Signing Identity - Development.xcconfig` → `Code Signing Identity.xcconfig`
2. **Sets** `CODE_SIGNING_REQUIRED = NO`
3. **Clears** `DEVELOPMENT_TEAM` and `PROVISIONING_PROFILE_SPECIFIER`
4. **Enables** ad-hoc code signing for local development

### **Scheme Purposes:**
- **Textual (Standard Release)**: Main production build
- **Textual (Debug)**: Development build with debug symbols
- **Textual (App Store)**: App Store distribution (requires certificates)
- **Textual (Standard Release Sandboxed)**: Sandboxed version
- **Build Frameworks**: Compiles all dependency frameworks first
- **Extensions**: Individual plugin components
- **XPC Services**: Background service components

## 📝 **Recommended Next Steps**

### **Immediate (This Week):**
1. **Set License Flag**: `TEXTUAL_BUILT_WITH_LICENSE_MANAGER=0` in config
2. **Document Current State**: Save all build warnings to reference
3. **Research Network.framework**: Study Apple's migration guides
4. **Plan SSL Migration**: This will be the biggest undertaking

### **Short Term (Next Month):**
1. **Fix Code Signing**: Get proper development builds without warnings
2. **Update Project Settings**: Accept Xcode's recommended settings
3. **Begin SSL Planning**: Design new networking architecture

### **Medium Term (3-6 Months):**
1. **Complete API Modernization**: All 119 warnings addressed
2. **Comprehensive Testing**: Ensure all IRC features work
3. **Performance Optimization**: Take advantage of modern APIs

## 🎯 **Success Metrics**

- [ ] **Zero Build Warnings**: Clean compile on macOS 26
- [ ] **Full IRC Functionality**: All original features work
- [ ] **Proper Code Signing**: No "unsigned" security dialogs
- [ ] **Modern Security**: NSSecureCoding, proper entitlements
- [ ] **Future-Proof**: Uses current APIs that won't be deprecated soon

## 💡 **Key Insight**

The good news: **The core IRC functionality already works!** This is primarily a **maintenance/modernization** project rather than a complete rewrite. The original Textual developers built a solid foundation - we just need to update it for current macOS standards.

This is exactly what happens to successful long-term macOS projects - they need periodic API updates to stay compatible with platform evolution.