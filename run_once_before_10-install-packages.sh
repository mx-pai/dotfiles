#!/bin/bash
#
# This script is run once by chezmoi to install essential packages.

# Exit on any error
set -e

echo "🚀 Starting one-time setup: Installing essential tools..."

# --- 1. Update package list and install base dependencies ---
echo "📦 Updating package list and installing base dependencies (curl, git, wget, gpg, go)..."
sudo apt-get update
sudo apt-get install -y curl git wget gpg golang-go

# --- 2. Install Starship (modern prompt) ---
echo "🚀 Installing Starship..."
# Use -y to skip confirmation
curl -sS https://starship.rs/install.sh | sh -s -- -y

# --- 3. Install Zoxide (smarter cd) ---
echo "🚀 Installing Zoxide..."
curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash

# --- 4. Install fzf (fuzzy finder) ---
echo "🚀 Installing fzf..."
if [ -d "$HOME/.fzf" ]; then
  echo "fzf directory already exists, skipping git clone."
else
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
fi
# Install binary but do not update RC files, as they are managed by chezmoi
~/.fzf/install --all --no-update-rc

# --- 5. Install eza (modern ls) ---
echo "🚀 Installing eza..."
sudo mkdir -p /etc/apt/keyrings
wget -qO- https://raw.githubusercontent.com/eza-community/eza/main/deb.asc | sudo gpg --dearmor -o /etc/apt/keyrings/gierens.gpg
echo "deb [signed-by=/etc/apt/keyrings/gierens.gpg] http://deb.gierens.de stable main" | sudo tee /etc/apt/sources.list.d/gierens.list
sudo chmod 644 /etc/apt/keyrings/gierens.gpg /etc/apt/sources.list.d/gierens.list
sudo apt-get update
sudo apt-get install -y eza

# --- 6. Install bat (modern cat) ---
echo "🚀 Installing bat..."
# On Debian/Ubuntu, the binary is often named batcat to avoid conflicts.
# The alias 'cat=batcat' is already in our fish config.
sudo apt-get install -y bat

# --- 7. Install lazydocker (Docker TUI) ---
echo "🚀 Installing lazydocker..."
# Ensure the go bin directory is available for this session
export PATH="$PATH:$(go env GOPATH)/bin"
go install github.com/jesseduffield/lazydocker@latest

echo "✅ All tools installed successfully!"
