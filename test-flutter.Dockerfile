FROM mcr.microsoft.com/devcontainers/base:debian

# Copy the flutter feature files
COPY src/flutter /tmp/flutter-feature

# Set working directory
WORKDIR /tmp/flutter-feature

# Test the installation
RUN chmod +x install.sh && \
    VERSION=stable CHANNEL=stable ENABLEWEBSUPPORT=true ./install.sh

# Verify installation
RUN flutter --version && \
    dart --version && \
    flutter doctor --version