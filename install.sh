#!/usr/bin/env bash

# Get the operating system name
os=$(uname -s)

echo "⏳ Setting up your $os..."


# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# MACOS #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
if [[ "$os" == "Darwin" ]]; then
    echo "Running MacOS installations..."

    # Install Xcode Command Line Tools if not already installed
    if ! xcode-select -p &>/dev/null; then
      echo "Installing Xcode Command Line Tools..."
      xcode-select --install
      until xcode-select -p &>/dev/null; do
        sleep 5
      done
    fi

    # Install Homebrew if not already installed
    if ! command -v brew &>/dev/null; then
      echo "Installing Homebrew..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
      echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
      eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Install applications via Brewfile
    if [[ -f ./Brewfile ]]; then
      echo "Installing applications from Brewfile..."
      brew bundle --file=./Brewfile
    else
      echo "Warning: Brewfile not found in current directory"
    fi
fi


# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# DEBIAN #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #


# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# Shared #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #

# Symlinking using to stow
stow git
stow shared
stow ssh
stow vim
stow zsh

# Optionally restart the shell
exec "$SHELL" -l
