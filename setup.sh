#!/bin/bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
DOTFILES_REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${GREEN}=== Dotfiles Setup ===${NC}"
echo "Repository location: $DOTFILES_REPO"
echo ""

# Function to backup existing file
backup_file() {
  local file=$1
  if [[ -e "$file" && ! -L "$file" ]]; then
    local backup="${file}.bak.$(date +%s)"
    echo -e "${YELLOW}Backing up existing $file to $backup${NC}"
    mv "$file" "$backup"
  elif [[ -L "$file" ]]; then
    echo -e "${YELLOW}Removing existing symlink: $file${NC}"
    rm "$file"
  fi
}

# Function to create symlink
create_symlink() {
  local source=$1
  local target=$2
  
  if [[ ! -e "$source" ]]; then
    echo -e "${RED}Error: Source file does not exist: $source${NC}"
    return 1
  fi
  
  backup_file "$target"
  ln -s "$source" "$target"
  echo -e "${GREEN}✓ Symlinked: $target -> $source${NC}"
}

# Create symlinks for Git config
echo -e "${YELLOW}Setting up Git configuration...${NC}"
create_symlink "$DOTFILES_REPO/git/gitconfig" "$HOME/.gitconfig"
create_symlink "$DOTFILES_REPO/git/aliases" "$HOME/.git-aliases"

# Create symlinks for Zsh config
echo -e "${YELLOW}Setting up Zsh configuration...${NC}"
create_symlink "$DOTFILES_REPO/zsh/zshrc" "$HOME/.zshrc"
create_symlink "$DOTFILES_REPO/zsh/aliases" "$HOME/.zsh-aliases"

# Create local config files if they don't exist
echo -e "${YELLOW}Setting up local configuration files...${NC}"
if [[ ! -e "$DOTFILES_REPO/git/gitconfig.local" ]]; then
  touch "$DOTFILES_REPO/git/gitconfig.local"
  echo -e "${GREEN}✓ Created: $DOTFILES_REPO/git/gitconfig.local${NC}"
else
  echo -e "${GREEN}✓ Already exists: $DOTFILES_REPO/git/gitconfig.local${NC}"
fi

if [[ ! -e "$DOTFILES_REPO/zsh/zshrc.local" ]]; then
  touch "$DOTFILES_REPO/zsh/zshrc.local"
  echo -e "${GREEN}✓ Created: $DOTFILES_REPO/zsh/zshrc.local${NC}"
else
  echo -e "${GREEN}✓ Already exists: $DOTFILES_REPO/zsh/zshrc.local${NC}"
fi

# Symlink local config files
echo -e "${YELLOW}Setting up local config symlinks...${NC}"
create_symlink "$DOTFILES_REPO/git/gitconfig.local" "$HOME/.gitconfig.local"
create_symlink "$DOTFILES_REPO/zsh/zshrc.local" "$HOME/.zshrc.local"

# Verify setup
echo ""
echo -e "${YELLOW}Verifying setup...${NC}"

# Check Git config
if git config user.name &>/dev/null; then
  echo -e "${GREEN}✓ Git config loaded successfully${NC}"
  echo "  User: $(git config user.name)"
else
  echo -e "${RED}✗ Git config failed to load${NC}"
fi

# Check Zsh config
if bash -c "source $HOME/.zshrc" 2>/dev/null; then
  echo -e "${GREEN}✓ Zsh config loaded successfully${NC}"
else
  echo -e "${RED}✗ Zsh config failed to load${NC}"
  echo "  Run: source $HOME/.zshrc to debug"
fi

echo ""
echo -e "${GREEN}=== Setup Complete ===${NC}"
echo "Your configuration is now symlinked to:"
echo "  ~/.gitconfig -> $DOTFILES_REPO/git/gitconfig"
echo "  ~/.git-aliases -> $DOTFILES_REPO/git/aliases"
echo "  ~/.zshrc -> $DOTFILES_REPO/zsh/zshrc"
echo "  ~/.zsh-aliases -> $DOTFILES_REPO/zsh/aliases"
echo ""
echo "Local configuration files (machine-specific):"
echo "  $DOTFILES_REPO/git/gitconfig.local"
echo "  $DOTFILES_REPO/zsh/zshrc.local"
echo ""
echo "Next steps:"
echo "  1. Edit gitconfig.local and zshrc.local for machine-specific settings"
echo "  2. Run: source $HOME/.zshrc to reload your shell"
echo "  3. (Optional) Install GitHub CLI: brew install gh && gh auth login"
