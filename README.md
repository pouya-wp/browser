# Cloud Remote Browser 🌐

<div align="center">

![Docker](https://img.shields.io/badge/Docker-DevContainer-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![Firefox](https://img.shields.io/badge/Firefox-Headless-FF7139?style=for-the-badge&logo=firefox&logoColor=white)
![noVNC](https://img.shields.io/badge/noVNC-HTML5_VNC-blue?style=for-the-badge)
![X11](https://img.shields.io/badge/Xvfb-Virtual_Display-gray?style=for-the-badge)
![Bash](https://img.shields.io/badge/Shell-Automation-4EAA25?style=for-the-badge&logo=gnu-bash&logoColor=white)

**Ephemeral, Containerized Remote Browser Environment with Web-Based VNC Access**

[Architecture](#architecture) • [Getting Started](#quick-start) • [Key Components](#core-components)

</div>

---

## ✦ Overview

**Cloud Remote Browser** provides a containerized, self-contained desktop browser instance designed for headless execution, automated browsing sessions, and web isolation. Powered by `Xvfb`, `x11vnc`, and `noVNC`, it exposes a full Firefox desktop browser accessible directly from any modern web browser over WebSockets (port 8080) without requiring local client installations.

---

## ⚡ Core Features

- **Web-Based VNC (noVNC)**: Stream 60 FPS remote desktop sessions over HTML5 WebSockets without software dependencies.
- **Virtual Framebuffer (Xvfb)**: Fully hardware-independent virtual X11 server running custom resolutions (1280x720x24).
- **Anti-Idling Keep-Alive Engine**: Low-overhead jitter daemon preventing Codespaces and DevContainer timeouts.
- **Fluxbox Window Management**: Ultra-lightweight memory footprint (<150 MB base RAM) ensuring high responsiveness.
- **Zero-Friction DevContainer**: 1-click bootstrap for GitHub Codespaces, VS Code Containers, and remote Docker instances.

---

## 🛠️ Architecture

```
+-------------------------------------------------------+
|                   DevContainer / Host                 |
|                                                       |
|   +---------------+      +------------------------+   |
|   |  Firefox GUI  | ---> |   Xvfb Display (:1)    |   |
|   +---------------+      +------------------------+   |
|                                     |                 |
|                                     v                 |
|                          +--------------------+       |
|                          | x11vnc (:5901)     |       |
|                          +--------------------+       |
|                                     |                 |
|                                     v                 |
|                          +--------------------+       |
|                          | websockify (noVNC) |       |
|                          +--------------------+       |
+-------------------------------------|-----------------+
                                      |
                                      v Port 8080 (HTTP/WS)
                         +--------------------------+
                         | Client Browser (Safari,  |
                         | Chrome, Firefox, Edge)   |
                         +--------------------------+
```

---

## 🚀 Quick Start

### Running via Codespaces / DevContainer

1. Open this repository in **GitHub Codespaces** or VS Code Remote Containers.
2. The environment automatically sets up the DevContainer.
3. Run the bootstrap script:
   ```bash
   bash setup.sh
   ```
4. Forward port `8080` (make it Public in Codespaces).
5. Navigate to `http://localhost:8080/vnc.html` in your browser to access the remote desktop.

---

<div align="center">
  <sub>Crafted with precision & passion by <b><a href="https://github.com/pouya-wp">Pouya Sadeghpour</a></b></sub>
</div>
