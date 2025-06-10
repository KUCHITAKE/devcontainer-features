#!/bin/bash -i

set -e

INSTALL_PROTOC_GEN_BUF_BREAKING="${INSTALLPROTOCGENBUFBREAKING:-"true"}"
INSTALL_PROTOC_GEN_BUF_LINT="${INSTALLPROTOCGENBUFLINT:-"true"}"

binary_names="buf"
if [[ "$INSTALL_PROTOC_GEN_BUF_BREAKING" == "true" ]]; then
    binary_names="$binary_names,protoc-gen-buf-breaking"
fi
if [[ "$INSTALL_PROTOC_GEN_BUF_LINT" == "true" ]]; then
    binary_names="$binary_names,protoc-gen-buf-lint"
fi

source ./library_scripts.sh

# nanolayer is a cli utility which keeps container layers as small as possible
# source code: https://github.com/devcontainers-extra/nanolayer
# `ensure_nanolayer` is a bash function that will find any existing nanolayer installations, 
# and if missing - will download a temporary copy that automatically get deleted at the end 
# of the script
ensure_nanolayer nanolayer_location "v0.5.4"

$nanolayer_location \
    install \
    devcontainer-feature \
    "ghcr.io/devcontainers-extra/features/gh-release:1.0.25" \
        --option repo='bufbuild/buf' \
        --option binaryNames="$binary_names" \
        --option version="$VERSION" \
        --option assetRegex='.*\.tar\.gz' \
        --option libName='buf'
    


echo 'Done!'