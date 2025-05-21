#!/bin/bash

set -e

source dev-container-features-test-lib

check "ros2 general directory found" test -d /opt/ros

# Report result
reportResults