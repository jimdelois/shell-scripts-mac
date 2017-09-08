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
git config --global user.email "jim@deloisweb.com"

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

### Node

echo "Installing Node"
brew install node
echo "Installed:"
echo "Node - `node -v`"
echo "NPM  - `npm -v`"

### Docker

echo "Installing Docker and Related Tools"
brew install --force docker docker-machine docker-compose docker-machine-nfs dnsmasq


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

