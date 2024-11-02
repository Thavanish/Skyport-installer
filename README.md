<div align="center">

<img src="data:image/svg+xml;base64,PHN2ZyB4bWxucz0iaHR0cDovL3d3dy53My5vcmcvMjAwMC9zdmciIHZpZXdCb3g9IjAgMCAyNDAgODAiPjxzdHlsZT4uYXtmb250LXNpemU6NDBweDtmb250LWZhbWlseTpBcmlhbCxzYW5zLXNlcmlmO2ZpbGw6IzMzMzt9QGtleWZyYW1lcyBmYWRle2Zyb217b3BhY2l0eTowfXRve29wYWNpdHk6MX19LnR7YW5pbWF0aW9uOmZhZGUgMnMgaW5maW5pdGUgYWx0ZXJuYXRlfTwvc3R5bGU+PHRleHQgeD0iMjAiIHk9IjUwIiBjbGFzcz0iYSB0Ij7wn5qAIFNreXBvcnQ8L3RleHQ+PC9zdmc+" width="240" height="80" alt="Skyport Logo">

# Skyport Installation System

[![License](https://img.shields.io/badge/license-Apache%202.0-blue.svg?style=for-the-badge&logo=apache)](LICENSE)
[![Version](https://img.shields.io/badge/version-1.0.0-brightgreen.svg?style=for-the-badge&logo=github)](https://github.com/Thavanish/Skyport-installer)
[![Platform](https://img.shields.io/badge/platform-debian-orange.svg?style=for-the-badge&logo=debian)]()
[![Node](https://img.shields.io/badge/node-v20.x-green.svg?style=for-the-badge&logo=node.js)]()
[![Docker](https://img.shields.io/badge/docker-required-blue.svg?style=for-the-badge&logo=docker)]()

<p align="center">
  <a href="#features">Features</a> •
  <a href="#installation">Installation</a> •
  <a href="#prerequisites">Prerequisites</a> •
  <a href="#support">Support</a>
</p>

</div>

---

<div align="center">

### 🚀 Quick Installation

</div>

```
wget https://raw.githubusercontent.com/Thavanish/Skyport-installer/refs/heads/main/installer.sh && bash installer.sh
```

<details>
<summary>🔍 Or use curl...</summary>

```bash
curl -sL https://raw.githubusercontent.com/Thavanish/Skyport-installer/main/installer.sh | bash
```

</details>

---

## 👥 Credits

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/Thavanish">
        <img src="/api/placeholder/100/100" width="100px;" alt="Thavanish"/>
        <br />
        <sub><b>Thavanish</b></sub>
      </a>
      <br />
      <sub>Installation Script Developer</sub>
    </td>
    <td align="center">
      <a href="https://github.com/skyportlabs">
        <img src="/api/placeholder/100/100" width="100px;" alt="SkyportLabs"/>
        <br />
        <sub><b>SkyportLabs</b></sub>
      </a>
      <br />
      <sub>Platform Provider</sub>
    </td>
  </tr>
</table>

## ✨ Features

<div align="center">

[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/colored.png)](#features)

</div>

<details open>
<summary><b>🎯 Core Features</b></summary>

- 🖥️ Interactive menu-driven installation
- 🧩 Component-based installation (Panel, Daemon, Dependencies)
- 🔧 Automatic dependency management
- 📝 Comprehensive installation logging

</details>

<details>
<summary><b>🛡️ Safety Features</b></summary>

- ✅ Pre-installation system checks
- ⚠️ Conflict detection
- 🔒 Secure default configurations
- 🧹 Automatic cleanup on failure

</details>

<details>
<summary><b>⚙️ Management Features</b></summary>

- 📊 Service monitoring via PM2
- 🔄 Automatic updates
- 🗑️ Clean uninstallation
- 📈 Performance tracking

</details>

## 📋 Prerequisites

> [!IMPORTANT]
> Make sure your system meets these requirements before installation:

- 🔑 Root access
- 🐧 Debian-based Linux distribution
- 🌐 Internet connectivity

> [!NOTE]
> For optimal performance, we recommend:
> - 2GB+ RAM
> - 20GB+ free disk space
> - 2+ CPU cores

## 🚀 Installation Options

<div align="center">

[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/colored.png)](#installation)

## 🔧 Components

<div align="center">

Component | Version | Status
----------|---------|--------
Skyport Panel | v0.2.2 | [![Status](https://img.shields.io/badge/status-stable-green.svg?style=flat-square)](https://github.com/skyportlabs/panel)
Skyport Daemon | v0.2.2 | [![Status](https://img.shields.io/badge/status-stable-green.svg?style=flat-square)](https://github.com/skyportlabs/skyportd)
Node.js | 20.x | [![Status](https://img.shields.io/badge/status-required-blue.svg?style=flat-square)]()
Docker | Latest | [![Status](https://img.shields.io/badge/status-required-blue.svg?style=flat-square)]()
PM2 | Latest | [![Status](https://img.shields.io/badge/status-required-blue.svg?style=flat-square)]()
Git | Latest | [![Status](https://img.shields.io/badge/status-required-blue.svg?style=flat-square)]()

</div>

## 📁 Directory Structure

<details>
<summary>Click to expand</summary>

```bash
/etc/
├── skyport/              # Panel installation
│   ├── config/           # Configuration files
│   ├── logs/            # Panel logs
│   └── data/            # Application data
│
└── skyportd/            # Daemon installation
    ├── config/          # Daemon configuration
    ├── logs/           # Daemon logs
    └── services/       # Service definitions
```

</details>

## ❗ Troubleshooting

> [!TIP]
> Common issues and solutions:

<details>
<summary>📋 Installation Fails</summary>

1. Check logs: `cat /var/log/skyport-install.log`
2. Verify permissions
3. Check internet connection
4. Ensure sufficient disk space

</details>

<details>
<summary>🔧 Service Won't Start</summary>

1. Check PM2 status: `pm2 status`
2. Verify port availability
3. Check service logs
4. Validate configuration

</details>

## 💬 Support

<div align="center">

[![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/colored.png)](#support)

</div>

> [!IMPORTANT]
> Need help? We've got you covered:

<kbd>[📖 Documentation](https://docs.skyportlabs.com)</kbd> • <kbd>[🐛 Issue Tracker](https://github.com/Thavanish/Skyport-installer/issues)</kbd> • <kbd>[💬 Discussions](https://github.com/Thavanish/Skyport-installer/discussions)</kbd>

## 📄 License

<details>
<summary>Apache License 2.0</summary>

```
Copyright 2024 Thavanish

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```

</details>

---

<div align="center">

**[⬆ back to top](#skyport-installation-system)**

Made by [Thavanish](https://github.com/Thavanish)
panel and daemon by [Skyportlabs](http://skyport.dev/)
</div>
