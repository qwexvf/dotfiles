if [ ! -d ~/neovim ]; then
  echo "Installing neovim"
  sleep 1
  sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip

  git clone https://github.com/neovim/neovim.git ~/neovim

  cd ~/neovim

  git checkout $(git tag | sort -V | tail -n 1)

  make -j4

  sudo make install
fi
