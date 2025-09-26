# EyeAreSea Build and Test Guide

## 🔧 **Development vs Production Environments**

### **Development Environment (Recommended for local work)**
```bash
# Switch to development environment
./dev-setup.sh dev

# Now you can build in Xcode GUI or CLI without Apple Developer certificate
```

### **Production Environment (For distribution only)**
```bash
# Switch to production environment (requires Apple Developer certificate)
./dev-setup.sh prod
```

### **Check Current Environment**
```bash
./dev-setup.sh status
```

## 🏗️ **Building the Project**

### **Method 1: Xcode GUI (Recommended for development)**
1. Ensure you're in development environment: `./dev-setup.sh dev`
2. Open `Textual.xcworkspace` in Xcode
3. Select "Textual (Standard Release)" scheme
4. Build with ⌘+B or Product → Build
5. ✅ Should build successfully without certificates

### **Method 2: Command Line**
```bash
# Ensure development environment
./dev-setup.sh dev

# Build with CLI
xcodebuild -workspace Textual.xcworkspace -scheme "Textual (Standard Release)" -configuration Release clean build
```

### **Method 3: GitHub Actions (Automatic)**
- Push code to GitHub
- GitHub Actions automatically builds and tests
- Uses Ubuntu environment with development tools
- No Apple Developer certificate needed

## 🧪 **Testing Workflows**

### **Local Testing Checklist**
1. **Build Test**: Ensure project builds without errors
2. **Run Test**: Launch the built app (if desired)
3. **Git Test**: Verify commits use MillerBOSS identity
4. **Environment Test**: Switch between dev/prod configs

### **GitHub Actions Testing**
- Automatically triggered on push/PR
- Claude Code integration testing
- Build verification in clean Ubuntu environment
- Security and configuration validation

## 📱 **Running the Built Application**

After successful build, the app is located at:
```
Build Results/Release/Textual.app
```

**To test run locally:**
```bash
# Navigate to build output
cd "Build Results/Release/"

# Launch the app (optional - for testing)
open Textual.app
```

⚠️ **Note**: The app may not run properly without proper code signing for all macOS security features, but it will build successfully.

## 🔐 **Privacy and Anonymity**

### **Git Configuration (Already Set)**
```bash
# Repository uses anonymous GitHub identity
git config user.name "MillerBOSS"
git config user.email "MillerBOSS@users.noreply.github.com"
```

### **Apple Developer Account**
- Development builds: **No Apple account needed**
- Production builds: Uses business Apple Developer account (when configured)
- Personal information: **Never committed to repository**

## 🚨 **Troubleshooting**

### **"Build Failed - Code Signing Error" in Xcode GUI**
```bash
# Solution: Switch to development environment
./dev-setup.sh dev

# Then rebuild in Xcode
```

### **"No such file or directory" CLI Build Error**
```bash
# Ensure you're in project root
pwd  # Should show: /Users/cyclone/Projects/EyeAreSea

# Ensure submodules are initialized
git submodule update --init --recursive
```

### **Personal Information Leaking**
```bash
# Check git identity
git config --local --list | grep user

# Should show only:
# user.name=MillerBOSS
# user.email=MillerBOSS@users.noreply.github.com
```

## 📋 **Build Verification Commands**

```bash
# 1. Check environment
./dev-setup.sh status

# 2. Verify git identity
git config --local user.name  # Should show: MillerBOSS

# 3. Build test
xcodebuild -workspace Textual.xcworkspace -scheme "Textual (Standard Release)" -configuration Release clean build | tail -5

# 4. Check build output
ls -la "Build Results/Release/"
```

## ⚙️ **Environment Files**

- **Active Config**: `Configurations/Build/Code Signing Identity.xcconfig`
- **Dev Template**: `Configurations/Build/Code Signing Identity - Development.xcconfig`
- **Prod Template**: `Configurations/Build/Code Signing Identity - Production.xcconfig`
- **Switch Script**: `dev-setup.sh`

## 🎯 **Recommended Workflow**

1. **Start Development Session**:
   ```bash
   ./dev-setup.sh dev
   git config --local user.name  # Verify: MillerBOSS
   ```

2. **Make Changes**: Edit code in Xcode or your preferred editor

3. **Test Build**: Build in Xcode GUI (⌘+B) or CLI

4. **Commit Changes**:
   ```bash
   git add .
   git commit -m "Your change description"
   git push origin master
   ```

5. **Verify GitHub Actions**: Check that automated builds pass

This ensures anonymous, secure development with working builds in both local and CI environments.