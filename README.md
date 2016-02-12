### Setup vim configuration
Get the `.vim` folder:
```sh
    git clone https://github.com/ssiccha/.vim.git ~/.vim
```

Create symlink for Neovim:
```sh
    ln -s ~/.vim ~/.config/nvim
```

If you do not want to install Neovim you can continue with the section [Install vim plugins](https://github.com/ssiccha/.vim#install-vim-plugins)

### Install neovim from package
    Neovim has been added to a Ubuntu PPA.
    More [information](https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu).
```sh
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim
```

### Install neovim from source
Check the [build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites),
e.g. recent verions of CMake and (Clang or GCC)
```sh
    sudo apt-get install libtool libtool-bin autoconf automake cmake \
        g++ pkg-config unzip libmsgpack-dev libuv-dev libluajit-5.1-dev
```

Build and install Neovim:
```sh
    git clone https://github.com/neovim/neovim ~/.local/opt/neovim
    cd ~/.local/opt/neovim
    make
    sudo make install
```

Make `nvim` binary available via `PATH`:
```sh
    ln -s ~/.local/opt/neovim/bin/nvim ~/.local/bin/nvim
    echo 'export PATH=$PATH:$HOME/.local/bin/' >> ~/.bashrc
```
Set `TERM` for neovim:
```sh
    echo 'export TERM="xterm-256color"' >> ~/.bashrc
    source ~/.bashrc
```
If you like, you can set up an alias for `nvim`:
```sh
    echo "alias 'vi'='nvim '" >> ~/.bashrc
```

### Make Python available in Neovim
Test whether `nvim` is able to use Python:
```sh
    nvim
    :python print "hello"
```

If this does not work, you can install the Python package `neovim` manually.
Prerequisites for the Python modules:
```sh
    sudo apt-get install python-dev python-pip python3-dev python3-pip
```

For more information you can check the Neovim documentation on
[Python in Neovim](https://neovim.io/doc/user/nvim_python.html)
```sh
    sudo pip2 install neovim
```

Typically `/usr/bin` contains a symbolic link `python2` to the latest python2 version.
If there is no such symlink, you have to change the path in vimrc:line19.
```vim
    let g:python_host_prog = '/path/to/your/python2'
```


### Install vim plugins
Install vim-plug, for more infosee https://github.com/junegunn/vim-plug#unix
```sh
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
```

Make sure that all YCM dependencies are available,
  see https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-installation
```sh
    sudo apt-get install build-essential cmake
    sudo apt-get install python-dev
```

Restart vim to reload .vimrc and `:PlugInstall` to install plugins via vim-plug.
YouCompleteMe is compiled with python2 at the end of calling :PlugInstall.
