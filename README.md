# DevContainer Features

A collection of DevContainer Features for development environments.

[![CI - Test Features](https://github.com/your-username/devcontainer-features/actions/workflows/test.yml/badge.svg)](https://github.com/your-username/devcontainer-features/actions/workflows/test.yml)
[![Flutter Feature Tests](https://github.com/your-username/devcontainer-features/actions/workflows/test-flutter.yml/badge.svg)](https://github.com/your-username/devcontainer-features/actions/workflows/test-flutter.yml)

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

## Testing & Continuous Integration

This project includes automated testing workflows:

### 🧪 Automated Testing

- **Multi-platform testing**: Debian, Ubuntu base images
- **Cross-architecture support**: amd64, arm64
- **Feature-specific scenarios**: Each feature has dedicated test scenarios
- **Performance monitoring**: Installation time tracking

### 📊 GitHub Actions Workflows

The project uses GitHub Actions for:

1. **Feature Testing** (`test.yml`): Tests all features across multiple configurations
2. **Flutter-Specific Testing** (`test-flutter.yml`): Comprehensive Flutter feature validation
3. **Release Management** (`release.yml`): Automated release creation and publishing

## Development

### Local Testing

Test a specific feature locally:

```bash
# Install devcontainer CLI
npm install -g @devcontainers/cli

# Test Flutter feature
devcontainer features test -f flutter

# Test specific scenario
devcontainer features test -f flutter --scenario test_stable_channel
```

### Docker Testing

Build and test using Docker:

```bash
# Build Flutter test container
docker build -f test-flutter.Dockerfile -t test-flutter .

# Validate installation
docker run --rm test-flutter flutter --version
docker run --rm test-flutter dart --version
```

### Adding New Features

1. Create feature directory: `src/your-feature/`
2. Add required files:
   - `devcontainer-feature.json`: Feature definition
   - `install.sh`: Installation script
   - `README.md`: Documentation
3. Create test files:
   - `test/your-feature/scenarios.json`: Test scenarios
   - `test/your-feature/test.sh`: Test validation
4. Update workflows if needed

### Development Standards

- Shell scripts should follow best practices
- JSON files must be valid
- Documentation should be complete and well-formatted
- All tests must pass before merging

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Ensure all tests pass locally
5. Submit a pull request

All contributions are automatically tested across multiple platforms and configurations.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Support

- 📖 **Documentation**: Check individual feature README files
- 🐛 **Issues**: Report bugs via GitHub Issues
- 💬 **Discussions**: Use GitHub Discussions for questions
- 🔄 **CI Status**: Monitor GitHub Actions for build status

---

**Note**: Replace `your-username` in the examples above with your actual GitHub username or organization name.
