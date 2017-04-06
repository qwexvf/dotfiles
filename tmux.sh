#!/bin/bash -xeu

if [ ! -d tmux ]; then
    git clone https://github.com/tmux/tmux.git
fi

cd tmux

# checkout latest tag
git checkout $(git tag | sort -V | tail -n 1)

sh autogen.sh

./configure

make -j4

sudo make install
