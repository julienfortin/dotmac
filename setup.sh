#!/bin/env bash

xcode-select -p
if [[ $? != 0 ]]; then echo 'Please install command line developper tools by running: "xcode-select --install"'; exit 1; fi

# agree to the Xcode licence
sudo xcodebuild -license

# homebrew
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile
sudo echo '/usr/local/opt/coreutils/libexec/gnuman' >> /etc/manpaths
echo 'You should check that "/usr/local/bin" is the first line of the "/private/etc/paths" file'

brew install caskroom/cask/brew-cask
# Some plugins to enable different files to work with Mac Quicklook.
# Includes features like syntax highlighting, markdown rendering, preview of jsons, patch files, csv, zip files etc.
brew cask install qlcolorcode
brew cask install qlstephen
brew cask install qlmarkdown
brew cask install quicklook-json
brew cask install qlprettypatch
brew cask install quicklook-csv
brew cask install betterzipql
brew cask install webpquicklook
brew cask install suspicious-package

#brew cask install appcleaner
#brew cask install android-file-transfer
#brew cask install cheatsheet

brew tap homebrew/dupes
brew install coreutils
brew install binutils
brew install diffutils
brew install ed --default-names
brew install findutils --with-default-names
brew install gawk
brew install gnu-indent --with-default-names
brew install gnu-sed --with-default-names
brew install gnu-tar --with-default-names
brew install gnu-which --with-default-names
brew install gnutls
brew install grep --with-default-names
brew install gzip
brew install screen
brew install watch
brew install wdiff --with-gettext
brew install wget
brew install curl
brew install bash
brew install emacs
brew install gdb
brew install gpatch
brew install m4
brew install make

brew install git
brew install svn
brew install less
brew install openssh
brew install python
brew install unzip

brew install valgrind
brew install gcc
brew install node
brew install rbenv ruby-build rbenv-gem-rehash rbenv-default-gems

# Install new fonts
brew install cabextract
mkdir -p /tmp/setup-dev-consolas && cd /tmp/setup-dev-consolas && && curl -O http://download.microsoft.com/download/f/5/a/f5a3df76-d856-4a61-a6bd-722f52a5be26/PowerPointViewer.exe && cabextract PowerPointViewer.exe && cabextract ppviewer.cab && open CONSOLA*.TTF 

brew install zsh zsh-completions
echo "fpath=(/usr/local/share/zsh-completions $fpath)" >> ~/.zshrc
rm -f ~/.zcompdump; compinit
echo "source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc


git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
echo "plugins+=(zsh-syntax-highlighting)" >> ~/.zshrc
echo "autoload -U compinit && compinit" >> ~/.zshrc

git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
echo "plugins+=(zsh-completions)" >> ~/.zshrc
echo "autoload -U compinit && compinit" >> ~/.zshrc

