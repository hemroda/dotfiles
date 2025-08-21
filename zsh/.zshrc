if [ ! -f "~/.aliases" ]; then
    source ~/.aliases
fi

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# Starship
eval "$(starship init zsh)"
