#!/bin/bash

set -e

source dev-container-features-test-lib

check "ros2 kilted directory found" test -d /opt/ros/kilted

# Report result
reportResults