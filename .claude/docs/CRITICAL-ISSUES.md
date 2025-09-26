# Critical Build & Runtime Issues

**Status**: Documented community-reported problems that may affect EyeAreSea
**Priority**: High - These issues could affect core connectivity

## 🚨 **Known Critical Issues**

### **Issue #1: XPC Service Connection Failures**
**Symptoms**: "Connection service closed unexpectedly" on IRC connect attempts
**Status**: ✅ NOT AFFECTING EyeAreSea (tested 2025-09-26)
**Impact**: Complete loss of IRC connectivity (community reports only)

**Technical Details:**
- Affects self-signed/development builds specifically
- Official signed releases work correctly
- XPC service (`IRC Connection Host.xpc`) crashes on startup
- Related to macOS security model and code signing

**Root Cause Analysis:**
```
Termination Reason: Namespace DYLD, Code 1 Library missing
Library not loaded: @rpath/CocoaExtensions.framework/Versions/A/CocoaExtensions
Referenced from: IRC Connection Host.xpc/Contents/MacOS/IRC Connection Host
```

**Files Affected:**
- `XPC Services/IRC Remote Connection Manager/`
- `Frameworks/CocoaExtensions.framework`
- Build system framework embedding

### **Issue #2: Framework Linking Problems**
**Symptoms**: CocoaExtensions.framework not found at runtime
**Status**: ⚠️ Critical for XPC services functionality
**Impact**: XPC services fail to launch, breaking core features

**Missing Framework Locations Searched:**
1. `/usr/lib/swift/CocoaExtensions.framework/` (system location)
2. `IRC Connection Host.xpc/Contents/MacOS/../Frameworks/` (relative path)
3. `IRC Connection Host.xpc/Contents/Frameworks/` (XPC bundle)
4. Main app `../../../../Frameworks/` (parent app frameworks)

**Problem**: Framework not being embedded in correct location for XPC services

### **Issue #3: License Manager Build Errors**
**Symptoms**: `Call to undeclared function 'TLOLicenseManagerAuthorizationCode'`
**Status**: ✅ Partially Addressed (set TEXTUAL_BUILT_WITH_LICENSE_MANAGER=0)
**Impact**: Build failures on recent Xcode versions

**Technical Details:**
- ISO C99 compliance issue with implicit function declarations
- Related to licensing code that EyeAreSea doesn't need
- Fixed by disabling license manager in build configuration

## 🔧 **Potential Solutions**

### **For XPC Service Issues:**
1. **Code Signing**: Proper development certificates for all components
2. **Framework Embedding**: Ensure CocoaExtensions.framework copied to XPC bundles
3. **Build Script Review**: Check framework copy phases in Xcode project
4. **Entitlements**: Verify XPC service entitlements are correct

### **For Framework Linking:**
1. **Build Phases**: Verify "Copy Frameworks" includes CocoaExtensions
2. **Rpath Settings**: Check @rpath configuration for XPC services
3. **Bundle Structure**: Ensure frameworks in correct locations
4. **Dependencies**: Verify all submodules built correctly

### **For License Manager:**
1. **✅ Completed**: Set `TEXTUAL_BUILT_WITH_LICENSE_MANAGER=0`
2. **Build Verification**: Test that builds complete without errors
3. **Runtime Testing**: Ensure licensing dialogs don't appear

## 🎯 **Action Plan**

### **Immediate Priority (This Week):**
1. **Test Current Build**: Verify if our development build has connectivity issues
2. **Framework Audit**: Check if CocoaExtensions.framework is properly embedded
3. **XPC Service Testing**: Test if IRC Remote Connection Manager works

### **High Priority (Next 2 Weeks):**
1. **Code Signing Fix**: Implement proper development certificates
2. **Framework Embedding**: Fix build system to embed frameworks correctly
3. **XPC Service Debugging**: Add logging to connection manager

### **Validation Results (2025-09-26):**
- [x] **Test IRC connectivity with current dev build** - ✅ SUCCESS
- [x] **Multiple networks tested** - ✅ Connected to multiple IRC networks
- [x] **10+ minutes stable connections** - ✅ No disconnections
- [ ] Verify XPC services launch without crashes
- [ ] Check framework locations in built app bundle
- [x] **Confirm no "Connection service closed unexpectedly" errors** - ✅ NO ERRORS

## 💡 **Key Insights from Community**

1. **Original Developer Warning**: "XPC service probably bugged with self signing" - suggests known issue
2. **Release vs Source**: Official releases work, source builds fail - points to build/signing issue
3. **macOS Security Model**: "Too many nuances" - Apple's security has gotten stricter
4. **Hidden Build Logs**: Check `.tmp` folder in project root for additional build information

## 🚩 **Red Flags to Watch For**

- Any "Connection service closed unexpectedly" messages
- XPC service crashes in Console.app
- Missing framework errors in crash logs
- Unsigned binary warnings from Little Snitch/security tools

This issue tracking will help ensure EyeAreSea avoids the connectivity problems that have plagued community builds of Textual.