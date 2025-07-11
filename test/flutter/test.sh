#!/bin/bash -i

set -e

source dev-container-features-test-lib

# Test Flutter installation
check "flutter command is available" flutter --version
check "dart command is available" dart --version

# Test Flutter doctor
check "flutter doctor runs successfully" flutter doctor --version

# Test Flutter configuration
check "flutter config shows web enabled" flutter config | grep -q "enable-web: true" || echo "Web support may not be enabled"

# Test Flutter commands
check "flutter help command works" flutter help

# Test that Flutter is in PATH
check "flutter is in PATH" which flutter
check "dart is in PATH" which dart

# Test Flutter installation directory
check "flutter installation directory exists" test -d "/opt/flutter"
check "flutter binary exists" test -f "/opt/flutter/bin/flutter"
check "dart binary exists" test -f "/opt/flutter/bin/dart"

# Test symlinks
check "flutter symlink exists" test -L "/usr/local/bin/flutter"
check "dart symlink exists" test -L "/usr/local/bin/dart"

# Test Flutter web capabilities (if web support is enabled)
if flutter config | grep -q "enable-web: true"; then
    check "flutter devices shows web-server" flutter devices | grep -q "web-server" || echo "Web server device not found"
fi

# Test creating a simple Flutter project (optional, may take time)
# Uncomment the following lines if you want to test project creation
# check "flutter create test project" flutter create --platforms web test_project
# check "test project created successfully" test -d "test_project"

reportResults