# ROS 2 Dev Container Feature

This repository provides a custom Dev Container Feature for easily setting up [Robot Operating System (ROS) 2](https://docs.ros.org/) in an Ubuntu-based development environment.

## Overview

- Installs ROS 2 automatically in Ubuntu-based Dev Containers
- Supported versions: jazzy, humble, rolling, kilted

## Usage

Example `devcontainer.json`:

```jsonc
{
  "image": "mcr.microsoft.com/devcontainers/base:noble",
  "features": {
    "ghcr.io/KUCHITAKE/devcontainer-features/ros2": {
      "version": "jazzy"
    }
  }
}
```

- Use the `version` option to select the ROS 2 release to install (`jazzy`, `humble`, `rolling`, or `kilted`).

## License

See [LICENSE](LICENSE).

## Links

- [ROS 2 Official Documentation](https://docs.ros.org/)
- [Dev Container Features Specification](https://containers.dev/implementors/features/)
