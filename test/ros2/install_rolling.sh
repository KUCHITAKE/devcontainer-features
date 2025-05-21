#!/bin/bash

set -e

source dev-container-features-test-lib

check "ros2 rolling directory found" test -d /opt/ros/rolling

# Report result
reportResults