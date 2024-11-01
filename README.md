# Skyport Installation System

A robust installation system for Skyport Panel and Daemon services.

## Features

- Interactive menu-driven installation
- Component-based installation (Panel, Daemon, Dependencies)
- Automatic dependency management
- Installation logging
- Directory conflict detection
- Service configuration with PM2
- Uninstallation capabilities

## Prerequisites

- Root access
- Debian-based Linux distribution
- Internet connectivity

## Quick Start

```bash
wget https://raw.githubusercontent.com/Thavanish/Skyport-installer/refs/heads/main/installer.sh && bash installer.sh
```

## Installation Options

1. **Install Everything**: Complete installation of Panel, Daemon, and all dependencies
2. **Install Panel Only**: Installs only the Skyport Panel component
3. **Install Daemon Only**: Installs only the Skyport Daemon component
4. **Install Dependencies Only**: Installs system dependencies without components
5. **Remove Panel**: Uninstalls the Panel component
6. **Remove Daemon**: Uninstalls the Daemon component
7. **Remove Dependencies**: Removes installed system dependencies

## Safety Features

- Checks for existing installations before proceeding
- Prompts for confirmation before overwriting existing files
- Comprehensive logging at `/var/log/skyport-install.log`
- Graceful cleanup on interruption

## Components Installed

- Skyport Panel (v0.2.2)
- Skyport Daemon (v0.2.2)
- Node.js 20.x
- Docker
- PM2 Process Manager
- Git

## Directory Structure

```
/etc/
├── skyport/     # Panel installation
└── skyportd/    # Daemon installation
```

## Logging

All installation steps are logged to `/var/log/skyport-install.log`

## Troubleshooting

If you encounter issues during installation:

1. Check the log file at `/var/log/skyport-install.log`
2. Ensure all prerequisites are met
3. Verify internet connectivity
4. Check system has sufficient disk space

## Uninstallation

Use options 5-7 in the installer menu to remove individual components or dependencies.

## Support

For support, please:
1. Check the log file
2. Visit our documentation at https://docs.skyportlabs.com
3. Open an issue on our GitHub repository

## License

apache 2.0 License - See LICENSE file for details
