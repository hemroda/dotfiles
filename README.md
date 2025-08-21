# dotfiles

## Installation

### If you only have curl (e.g fresh macOS install)

```sh
<(curl -fsSL https://github.com/hemroda/dotfiles/raw/master/install_no_git.sh)
```

### If you have Git

```sh
git clone https://github.com/hemroda/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

## Misc

### Generate SSH key and add it to Github or Gitlab

```sh
ssh-keygen -t ed25519 -C "your_email@example.com"
```

```sh
eval "$(ssh-agent -s)"
```

```sh
cat ~/.ssh/id_ed25519.pub
```