# EyeAreSea Feature Requests

**Status**: Enhancement requests for improved user experience
**Priority**: Medium - Quality of life improvements

## 🎨 **UI/UX Enhancements**

### **Feature Request #1: Adjustable Font Sizes for Sidebar Panels**
**Priority**: Medium
**Requested By**: User feedback
**Status**: 📋 Planned

**Description:**
Add user-configurable font size controls for the left sidebar (channel list) and right sidebar (nickname list) panels to improve accessibility and user preference customization.

**Current State Analysis:**
- Font sizes are currently hardcoded in various locations
- Some infrastructure exists but not exposed to user preferences
- Related code found in appearance management system

**Technical Implementation Details:**

**Existing Code Locations:**
```
Sources/App/Classes/Views/TVCAppearance.m:45 (appearance management)
Sources/App/Classes/Headers/TVCAppearance.h:71 (appearance headers)
```

**Configuration Files (Potential Locations):**
```
Textual.app/Contents/Resources/TVC*.plist files
```

**Implementation Plan:**
1. **Research Current System**: Investigate existing font size management
2. **UI Controls**: Add font size sliders/controls to Preferences panel
3. **Persistence**: Store settings in user preferences
4. **Live Updates**: Apply changes without restart required
5. **Accessibility**: Ensure compatibility with system accessibility settings

**Affected Components:**
- Channel list (left sidebar)
- Nickname list (right sidebar)
- Preferences panel (new controls)
- TVCAppearance system (font management)

**User Story:**
"As a user with visual accessibility needs, I want to increase the font size in the channel and nickname lists so that I can more easily read the interface elements."

**Acceptance Criteria:**
- [ ] Font size controls added to Preferences
- [ ] Changes apply immediately (no restart required)
- [ ] Settings persist across application restarts
- [ ] Supports reasonable size range (e.g., 9pt to 18pt)
- [ ] Maintains proper UI layout at all sizes
- [ ] Integrates with system accessibility settings

## 🔧 **Technical Enhancement Requests**

### **Future Considerations:**
- Dark mode improvements
- Custom color schemes
- Interface scaling options
- Keyboard shortcuts customization
- Better notification controls

## 📋 **Implementation Roadmap**

### **Phase 1: Research & Planning**
- [ ] Audit existing font management system
- [ ] Design preference UI mockups
- [ ] Plan implementation approach

### **Phase 2: Core Implementation**
- [ ] Add preference controls
- [ ] Implement font size logic
- [ ] Add persistence layer

### **Phase 3: Polish & Testing**
- [ ] Test all font sizes
- [ ] Ensure proper layout
- [ ] Accessibility testing
- [ ] User acceptance testing

**Estimated Effort**: 1-2 weeks after core modernization complete
**Dependencies**: Complete API modernization first to ensure stable foundation