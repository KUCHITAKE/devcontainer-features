#!/bin/bash -i

set -e

source dev-container-features-test-lib

check "buf --version" buf --version
check "check 'protoc-gen-buf-breaking' is in the PATH" type protoc-gen-buf-breaking
check "check 'protoc-gen-buf-lint' is in the PATH" type protoc-gen-buf-lint

reportResults