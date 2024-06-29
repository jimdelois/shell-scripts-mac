DIR=$(pwd)

### Oh My Zsh
echo "Installing Oh My Zsh";
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"


### Brew

echo "Installing Brew";
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo "Updating Brew";
brew update

### XCode

echo "Installing XCode (Minimal)";
xcode-select --install

### Git

echo "Configuring Git User Commit Details"
git config --global user.name "Jim DeLois"
git config --global user.email "jimdelois@users.noreply.github.com"
git config --global core.excludesfile ~/.gitignore

# Link the Included Git Ignore File
if [ -e ~/.gitignore ]
then
  echo "Linking the Git Ignore File"
  ln -s $DIR/gitignore ~/.gitignore
fi

# Install Git Prompt
echo "Setting up Git Completion and Prompts"
brew install git bash-completion
curl -o ~/git-prompt.sh https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh

echo "Installing Hub"
brew install hub

## TODO: Consider also installing gh
## https://cli.github.com/
# brew install gh

### PHP
echo "Setting up PHP"
brew install php
echo "Installing System-wide PHPMD"
brew install phpmd
echo "Installing System-wide PHPCS"
brew install php-code-sniffer
pecl xdebug
# pecl install intl
# brew install homebrew/php/php-cs-fixer

# See: https://gist.github.com/jimdelois/245c50bd7d31baa774c07644a39f30f9
echo "Configuring Personal XDebug Toggler"
curl -o $DIR/install_xdebug_toggle.sh https://gist.githubusercontent.com/jimdelois/245c50bd7d31baa774c07644a39f30f9/raw/install_xdebug_toggle.sh
chmod +x $DIR/install_xdebug_toggle.sh
php -i | grep xdebug.ini | xargs ./install_xdebug_toggle.sh
rm -rf ./install_xdebug_toggle.sh

echo "Installing Composer"
brew install composer
echo "NOTE: Please run composer config -g github-oauth.github.com YOUR_TOKEN_HERE"

# No longer part of Brew? Try using Composer in the future...
#echo "Installing System-wide Phing"
#brew install phing


### Node

echo "Installing Node"
# curl -L http://git.io/n-install | bash -s -- -n
brew install n
n lts
echo "Installed:"
echo "Node - `node -v`"
echo "NPM  - `npm -v`"

### Bash

# Link the Included Bash Profile Script
if [ -e ~/.bash_profile ]
then
  echo "Linking the Bash Profile Script"
  ln -s $DIR/bash_profile ~/.bash_profile
fi

### Zsh
if [ -e ~/.zshrc ]
then
  echo "Linking the Zsh Profile Script"
  ln -s $DIR/zshrc ~/.zshrc
fi

### SSH
if [ -e ~/.ssh ]
then
  echo "Copying the SSH Directory"
  cp -r $DIR/ssh ~/.ssh
  chmod 700 ~/.ssh
  chmod 600 ~/.ssh/id_rsa
  chmod 644 ~/.ssh/id_rsa.pub
fi

# Secrets, etc.
echo "Linking local secrets file"
ln -s $DIR/bash_secrets ~/.bash_secrets


### DNSMasq

echo "Installing DNSMasq"
brew install --force dnsmasq

echo "Configuring DNSMasq"
rm /usr/local/etc/dnsmasq.conf 2>/dev/null
ln -s $DIR/dnsmasq.conf /usr/local/etc/dnsmasq.conf

brew tap homebrew/services

sudo brew services stop dnsmasq
sudo brew services start dnsmasq

echo "Setting Up Resolver"
sudo mkdir /etc/resolver
sudo ln -s $DIR/local.lan /etc/resolver/local.lan

echo "Installing Marina"
brew install jimdelois/macosx/marina

### Python

echo "Installing Python 2.7"
brew install --force python@2


### Scala
echo "Installing Scala and SBT (with Open JDK)"
brew install adoptopenjdk
brew install --force scala
brew install --force sbt

### AWS
echo "Installing the AWS CLI"
brew install awscli

### Terminal

echo "Setting up iTerm Configurations"

# iTerm Shell Integration
# NOTE: There is now a profile-specific setting to automatically enable shell integration
ln -s $DIR/terminal/iterm2_shell_integration.bash ~/.iterm2_shell_integration.bash

# iTerm Profiles
if [ -e ~/Library/Application\ Support/iTerm2/DynamicProfiles ]
then
  mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
fi
ln -s $DIR/terminal/iterm2-dynamic-profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/iterm2-dynamic-profiles.json


if [ -e ~/.config ]
then
  mkdir -p ~/.config
fi


### Mac OS X

if [ -e ~/Pictures/Screenshots ]
then
  mkdir ~/Pictures/Screenshots
fi

echo "Updating Default Screenshot Location"
defaults write com.apple.screencapture location ~/Pictures/Screenshots
killall SystemUIServer


### Powerline Fonts
# See: https://github.com/powerline/fonts?tab=readme-ov-file#installation
echo "Installing Powerline Fonts"
source ./install_powerline_fonts.sh

### iTerm Themes
# See: https://github.com/mbadolato/iTerm2-Color-Schemes/tree/master?tab=readme-ov-file#installation-instructions
# Theme gallery at: https://iterm2colorschemes.com/
echo "Installing iTerm Themes"
source ./install_iTerm_themes.sh
echo "(please restart iTerm to make these themes available)"

### Zsh Theme Customizations
echo "Installing Zsh Customizations"
if [ -e ~/.oh-my-zsh/custom/themes ]
then
  echo "Linking Zsh Theme Customizations"
  echo " - Agnoster"
  ln -s $DIR/terminal/zsh-customizations/themes/agnoster.zsh-theme ~/.oh-my-zsh/custom/themes/agnoster.zsh-theme
fi
