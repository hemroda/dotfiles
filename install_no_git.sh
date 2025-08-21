#!/usr/bin/env bash

# Get the operating system name
os=$(uname -s)

REPO_URL="https://gitlab.com/hemroda/dotfiles.git"
CLONE_DIR="$HOME"

# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
# MACOS                                                                   #
# ----------------------------------------------------------------------- #
# ----------------------------------------------------------------------- #
if [[ "$os" == "Darwin" ]]; then

    ssh-add --apple-use-keychain ~/.ssh/id_ed25519

    # Step 1: Install Xcode Command Line Tools (includes Git)
    if ! command -v git &> /dev/null; then
        echo "🔧 Installing Xcode Command Line Tools (required for Git)..."
        xcode-select --install

        # Wait until installation is complete
        until command -v git &> /dev/null; do
            sleep 5
        done
        echo "✅ Git is now installed."
    fi

    # Step 2: Install Homebrew
    if ! command -v brew &> /dev/null; then
        echo "🍺 Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> "$HOME/.zprofile"
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi

    # Step 3: Clone the repo if it hasn't been cloned yet
    if [ ! -d "$CLONE_DIR/dotfiles" ]; then
        echo "📥 Cloning dotfiles into $CLONE_DIR/dotfiles..."
        git clone "$REPO_URL" "$CLONE_DIR/dotfiles"
    else
        echo "📁 Directory $CLONE_DIR/dotfiles already exists. Skipping clone."
    fi

    # Re-source Homebrew env just in case
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Step 4: Run main install script
    cd "$CLONE_DIR/dotfiles"
    echo "🚀 Running main install script..."
    exec ./install.sh

fi
