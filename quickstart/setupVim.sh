#!/bin/bash
#### @Davesdere | David Cote 2018
# encoding: utf-8
### Bash Script to setup my fav vim config because I'm lazy like that.
## Uncomment next line to remove a config that is already in place
#rm ~/.vimrc
echo "#### @Davesdere | David Cote 2018"
echo "Setting up vim config"
touch ~/.vimrc
echo "syntax enable" >> ~/.vimrc
echo "set tabstop=4" >> ~/.vimrc
echo "set shiftwidth=4" >> ~/.vimrc
echo "set expandtab" >> ~/.vimrc
echo "set number" >> ~/.vimrc
echo "filetype indent on" >> ~/.vimrc
echo "set autoindent" >> ~/.vimrc
echo "colorscheme desert" >> ~/.vimrc
echo "Davesdere's Vim Config has been setup. Buy him a beer!"