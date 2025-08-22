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
stow config
stow git
stow shared
stow ssh
stow tmux
stow vim
stow zsh

# Tmux Plugins
DEST_DIR="$HOME/.tmux/plugins/tpm"

# Check if the directory exists and if it's empty
if [ -d "$DEST_DIR" ] && [ -z "$(ls -A "$DEST_DIR")" ]; then
  # If the directory exists but is empty, then clone
  echo "Directory $DEST_DIR exists but is empty. Cloning repository."
  git clone https://github.com/tmux-plugins/tpm "$DEST_DIR"
elif [ -d "$DEST_DIR" ] && [ ! -z "$(ls -A "$DEST_DIR")" ]; then
  # If the directory exists and is NOT empty, do nothing
  echo "Directory $DEST_DIR exists and is not empty. Skipping clone."
else
  # If the directory does not exist, clone
  echo "Directory $DEST_DIR does not exist. Cloning repository."
  git clone https://github.com/tmux-plugins/tpm "$DEST_DIR"
fi


# Optionally restart the shell
exec "$SHELL" -l
