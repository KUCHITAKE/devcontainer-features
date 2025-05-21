#!/bin/bash

set -e

source dev-container-features-test-lib

check "ros2 jazzy directory found" test -d /opt/ros/jazzy

# Report result
reportResults