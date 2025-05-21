#!/bin/bash

set -euo pipefail  # Exit on error, undefined variable, or failed pipeline

# shellcheck source=/dev/null
DISTRO_ID="$(. /etc/os-release && echo "${ID}")"
readonly DISTRO_ID

# Check if running on Ubuntu
if [[ "${DISTRO_ID,,}" != "ubuntu" ]]; then
  echo "install.sh: ubuntu distribution required: detected '${DISTRO_ID}'" >&2
  exit 1
fi

# Check if VERSION environment variable is set
if [[ -z "${VERSION:-}" ]]; then
  echo "install.sh: VERSION environment variable is not set." >&2
  exit 1
fi

# Prevent interactive prompts during apt/dpkg operations
export DEBIAN_FRONTEND=noninteractive

apt-get update

# Install required packages in a single step
apt-get install --yes --quiet --no-install-recommends \
  locales software-properties-common curl

# ROS requires UTF-8 locale (idempotent)
locale-gen en_US en_US.UTF-8 || true
update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

export LANG=en_US.UTF-8

# Add universe repository
add-apt-repository universe

# Download official ROS 2 GPG key
curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key \
  -o /usr/share/keyrings/ros-archive-keyring.gpg

# Add ROS 2 repository
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo "${UBUNTU_CODENAME}") main" \
  | tee /etc/apt/sources.list.d/ros2.list > /dev/null

# Update to get new repository package list
apt-get update

# Install core ROS 2 and development tools
apt-get install --yes --quiet --no-install-recommends \
  ros-"${VERSION}"-ros-base \
  ros-dev-tools

# Clean up apt cache and lists
apt-get clean
rm -rf /var/lib/apt/lists/*