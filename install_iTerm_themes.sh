#!/bin/bash

echo "Cloning git@github.com:mbadolato/iTerm2-Color-Schemes.git"
git clone --depth 1 git@github.com:mbadolato/iTerm2-Color-Schemes.git

echo "Installing Themes..."
cd iTerm2-Color-Schemes
./tools/import-scheme.sh -v schemes/*

echo "Removing mbadolato/iTerm2-Color-Schemes.git"
cd ..
rm -rf iTerm2-Color-Schemes/
