#!/bin/bash

# EyeAreSea Development Environment Setup
# Switches between development and production code signing configurations

set -e

CONFIG_DIR="Configurations/Build"
CURRENT_CONFIG="$CONFIG_DIR/Code Signing Identity.xcconfig"
DEV_CONFIG="$CONFIG_DIR/Code Signing Identity - Development.xcconfig"
PROD_CONFIG="$CONFIG_DIR/Code Signing Identity - Production.xcconfig"

show_help() {
    echo "Usage: $0 [dev|prod|status|help]"
    echo ""
    echo "Commands:"
    echo "  dev     - Switch to development environment (no Apple Developer cert required)"
    echo "  prod    - Switch to production environment (requires Apple Developer cert)"
    echo "  status  - Show current environment configuration"
    echo "  help    - Show this help message"
    echo ""
    echo "Development Environment:"
    echo "  - No code signing required"
    echo "  - Builds work in Xcode GUI and CLI"
    echo "  - No Apple Developer account needed"
    echo "  - Good for local development and testing"
    echo ""
    echo "Production Environment:"
    echo "  - Requires valid Apple Developer certificate"
    echo "  - Needed for App Store or distribution builds"
    echo "  - Enables sandboxing and entitlements"
}

switch_to_dev() {
    echo "🔧 Switching to DEVELOPMENT environment..."
    cp "$DEV_CONFIG" "$CURRENT_CONFIG"
    echo "✅ Development environment active"
    echo "   - No Apple Developer certificate required"
    echo "   - Safe for local development"
    echo "   - Builds will work in Xcode GUI"
}

switch_to_prod() {
    echo "🔧 Switching to PRODUCTION environment..."
    cp "$PROD_CONFIG" "$CURRENT_CONFIG"
    echo "✅ Production environment active"
    echo "   - Requires Apple Developer certificate"
    echo "   - Needed for distribution builds"
    echo "   - ⚠️  May fail without proper certificates"
}

show_status() {
    echo "Current Code Signing Configuration:"
    echo "=================================="
    if [[ -f "$CURRENT_CONFIG" ]]; then
        echo "File: $CURRENT_CONFIG"
        echo ""
        grep -E "(CODE_SIGN_IDENTITY|CODE_SIGNING_REQUIRED|DEVELOPMENT_TEAM)" "$CURRENT_CONFIG" | sed 's/^/  /'
        echo ""

        # Determine environment based on CODE_SIGNING_REQUIRED
        if grep -q "CODE_SIGNING_REQUIRED = NO" "$CURRENT_CONFIG"; then
            echo "Environment: DEVELOPMENT (no cert required)"
        else
            echo "Environment: PRODUCTION (cert required)"
        fi
    else
        echo "❌ Configuration file not found: $CURRENT_CONFIG"
    fi
}

# Check if we're in the right directory
if [[ ! -d "$CONFIG_DIR" ]]; then
    echo "❌ Error: Must be run from the EyeAreSea project root directory"
    exit 1
fi

case "${1:-help}" in
    dev)
        switch_to_dev
        ;;
    prod)
        switch_to_prod
        ;;
    status)
        show_status
        ;;
    help)
        show_help
        ;;
    *)
        echo "❌ Unknown command: $1"
        show_help
        exit 1
        ;;
esac