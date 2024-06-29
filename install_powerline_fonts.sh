#!/bin/bash

echo "Cloning git@github.com:powerline/fonts.git"
git clone --depth 1 git@github.com:powerline/fonts.git

echo "Installing Fonts..."
cd fonts
./install.sh

echo "Removing powerline/fonts.git files"
cd ..
rm -rf fonts/
