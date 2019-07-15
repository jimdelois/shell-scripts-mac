DIR=$(pwd)

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

### PHP
echo "Setting up PHP"
brew tap homebrew/php
brew install homebrew/php/php71
brew install homebrew/php/php71-intl
brew install homebrew/php/php71-xdebug
# brew install homebrew/php/phpmd
# brew install homebrew/php/php-code-sniffer
# brew install homebrew/php/php-cs-fixer

echo "Configuring Personal XDebug Toggler"
curl -o $DIR/install_xdebug_toggle.sh https://gist.githubusercontent.com/jimdelois/245c50bd7d31baa774c07644a39f30f9/raw/install_xdebug_toggle.sh
chmod +x $DIR/install_xdebug_toggle.sh
php -i | grep xdebug.ini | xargs ./install_xdebug_toggle.sh
rm -rf ./install_xdebug_toggle.sh

echo "Installing Composer"
brew install composer
echo "NOTE: Please run composer config -g github-oauth.github.com YOUR_TOKEN_HERE"

echo "Installing System-wide PHPMD"
brew install phpmd

echo "Installing System-wide PHPCS"
brew install php-code-sniffer

echo "Installing System-wide Phing"
brew install phing


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


### Docker

echo "Installing Docker and Related Tools"
brew install --force docker docker-machine docker-compose docker-machine-nfs dnsmasq

echo "Please ensure that VMWare is downloaded and installed, then run:"
echo "$DIR/local_docker_setup.sh"

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


### Terminal

echo "Setting up iTerm Configurations"

# iTerm Shell Integration
ln -s $DIR/terminal/iterm2_shell_integration.bash ~/.iterm2_shell_integration.bash

# iTerm Profiles
if [ -e ~/Library/Application\ Support/iTerm2/DynamicProfiles ]
  mkdir -p ~/Library/Application\ Support/iTerm2/DynamicProfiles
fi
ln -s $DIR/terminal/iterm2-dynamic-profiles.json ~/Library/Application\ Support/iTerm2/DynamicProfiles/iterm2-dynamic-profiles.json

echo "Installing Powerline and its Customizations"
pip install powerline-status

if [ -e ~/.config ]
  mkdir -p ~/.config
fi

ln -s $DIR/terminal/powerline ~/.config/powerline
echo "Powerline has been installed.  Please install Source Code Pro and other fonts from https://github.com/powerline/fonts"

### Mac OS X

if [ -e ~/Pictures/Screenshots ]
  mkdir ~/Pictures/Screenshots
fi

echo "Updating Default Screenshot Location"
defaults write com.apple.screencapture location ~/Pictures/Screenshots
killall SystemUIServer
