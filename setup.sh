#!/bin/bash
# Simple setup.sh for configuring Ubuntu 12.04 LTS EC2 instance
# for headless setup. 

# Install nvm: node-version manager
# https://github.com/creationix/nvm
sudo apt-get install -y git-core
curl https://raw.github.com/creationix/nvm/master/install.sh | sh

# Load nvm and install latest production node
source $HOME/.nvm/nvm.sh
nvm install v0.10.12
nvm use v0.10.12

# Install jshint to allow checking of JS code within emacs
# http://jshint.com/
npm install -g jshint

# Install rlwrap to provide libreadline features with node
# See: http://nodejs.org/api/repl.html#repl_repl
sudo apt-get install -y rlwrap

#Install useful vim plugins
#Pathogen
mkdir -p ~/.vim/autoload ~/.vim/bundle; curl -Sso ~/.vim/autoload/pathogen.vim https://raw.github.com/tpope/vim-pathogen/master/autoload/pathogen.vim

#Create .vimrc
cd $HOME
if [ -s ~/.vimrc ]; then
	grep -qv "execute pathogen#infect()" || echo "execute pathogen#infect()" >> ~/.vimrc
else 
	echo "execute pathogen#infect()" > ~/.vimrc
	echo "syntax on" >> ~/.vimrc
	echo "filetype plugin indent on" >> ~/.vimrc
	echo 'let g:slime_target = "screen"' >> ~/.vimrc
	echo "let g:syntastic_always_populate_loc_list=1" >> ~/.vimrc
fi

#Add plug ins
cd ~/.vim/bundle
git clone git://github.com/jpalardy/vim-slime.git
git clone https://github.com/scrooloose/syntastic.git
git clone git://github.com/tpope/vim-fugitive.git

# git pull and install dotfiles as well
cd $HOME
if [ -d ./dotfiles/ ]; then
    mv dotfiles dotfiles.old
fi
git clone https://github.com/acorred1/dotfiles.git
ln -sb dotfiles/.screenrc .
ln -sb dotfiles/.bash_profile .
ln -sb dotfiles/.bashrc .
ln -sb dotfiles/.bashrc_custom .
