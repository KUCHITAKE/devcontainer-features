#!/bin/bash

set -e

source dev-container-features-test-lib

check "ros2 humble directory found" test -d /opt/ros/humble

# Report result
reportResults