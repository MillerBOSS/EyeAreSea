# Security Policy

## Repository Security Practices

### Authentication & Authorization
- **Repository Owner**: MillerBOSS only
- **GitHub Actions**: Restricted to MillerBOSS user only
- **SSH Access**: Dedicated SSH key per account (no shared keys)
- **API Access**: Least privilege scopes only

### Sensitive Data Protection
- **Code Signing**: Private keys never committed (stored in Keychain only)
- **API Keys**: GitHub Secrets only, never in source code
- **Build Artifacts**: Excluded from repository via .gitignore
- **Credentials**: All authentication data excluded from git

### GitHub Actions Security
- **Trigger Restriction**: Only MillerBOSS can invoke @claude
- **Tool Limitations**: Limited to `bash`, `git`, `xcodebuild` only
- **Permission Scope**: Minimal required permissions
- **Submodule Safety**: Recursive checkout with depth limits

### File Exclusions (via .gitignore)
- Private keys (*.pem, *.key, *.p12, etc.)
- Build artifacts and sensitive data
- IDE configuration files with credentials
- System files and caches
- SSH and git credential files

### Build Security
- **Code Signing**: Required via .xcconfig (never disabled)
- **Sandboxing**: Maintained for macOS security model
- **Submodules**: Verified trusted dependencies only
- **Build Environment**: Clean build processes

### Backup Procedures
- **SSH Config**: Backed up before modifications (timestamped)
- **Critical Configs**: Version controlled where appropriate
- **Recovery**: Documented restoration procedures

## Reporting Security Issues

For security concerns specific to this fork, contact the repository owner.

For issues with the original Textual codebase, refer to the upstream repository's security policy.