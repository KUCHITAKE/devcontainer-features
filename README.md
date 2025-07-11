# DevContainer Features

A collection of DevContainer Features for development environments.

## Available Features

### 🎯 Flutter
Install Flutter SDK for web development with cross-architecture support.

- **Channels**: stable, beta, dev, master
- **Architectures**: x86_64, aarch64
- **Web Support**: Configurable
- **Auto-configuration**: Git repository, analytics disabled

```json
{
  "features": {
    "ghcr.io/your-username/devcontainer-features/flutter": {
      "version": "stable",
      "channel": "stable",
      "enableWebSupport": true
    }
  }
}
```

### 🔧 Buf
Protocol Buffers toolchain for API development.

```json
{
  "features": {
    "ghcr.io/your-username/devcontainer-features/buf": {}
  }
}
```

### 🤖 OpenCommit
AI-powered commit message generator.

```json
{
  "features": {
    "ghcr.io/your-username/devcontainer-features/opencommit": {}
  }
}
```

### 🚀 ROS2
Robot Operating System 2 for robotics development.

```json
{
  "features": {
    "ghcr.io/your-username/devcontainer-features/ros2": {}
  }
}
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
