#!/bin/bash

# Script to install Go 1.23.4 and set up workspaces

# Variables
GO_URL="https://go.dev/dl/go1.23.4.linux-amd64.tar.gz"
INSTALL_DIR="/usr/local"
GOROOT="$INSTALL_DIR/go"
GOPATH="$HOME/go"

# Step 1: Download Go
echo "Downloading Go 1.23.4..."
wget "$GO_URL" -O /tmp/go1.23.4.linux-amd64.tar.gz

# Step 2: Remove existing Go installation (if any)
if [ -d "$GOROOT" ]; then
    echo "Removing existing Go installation at $GOROOT..."
    sudo rm -rf "$GOROOT"
fi

# Step 3: Extract Go
echo "Extracting Go to $INSTALL_DIR..."
sudo tar -C "$INSTALL_DIR" -xzf /tmp/go1.23.4.linux-amd64.tar.gz

# Step 4: Set up environment variables
echo "Configuring environment variables..."

# Detect the shell profile file
if [ -n "$($SHELL -c 'echo $ZSH_VERSION')" ]; then
    SHELL_PROFILE="$HOME/.zshrc"
elif [ -n "$($SHELL -c 'echo $BASH_VERSION')" ]; then
    SHELL_PROFILE="$HOME/.bashrc"
else
    SHELL_PROFILE="$HOME/.profile"
fi

# Add Go environment variables to the shell profile
echo "export GOROOT=$GOROOT" >> "$SHELL_PROFILE"
echo "export GOPATH=$GOPATH" >> "$SHELL_PROFILE"
echo 'export PATH=$PATH:$GOROOT/bin:$GOPATH/bin' >> "$SHELL_PROFILE"

# Step 5: Create Go workspaces
echo "Creating Go workspaces..."
mkdir -p "$GOPATH"/{bin,pkg,src}

# Step 6: Clean up
echo "Cleaning up..."
rm -f /tmp/go1.23.4.linux-amd64.tar.gz

# Step 7: Verify installation
echo "Verifying Go installation..."
source "$SHELL_PROFILE"
go version

echo "Go 1.23.4 has been successfully installed and configured!"
echo "Please restart your terminal or run 'source $SHELL_PROFILE' to apply the changes."
