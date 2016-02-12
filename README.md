### Setup vim configuration
Get the `.vim` folder:
```sh
    git clone https://github.com/ssiccha/.vim.git ~/.vim
```

If you **do not want** to install **Neovim** you can continue with the section [Install vim plugins](https://github.com/ssiccha/.vim#install-vim-plugins)

### Install neovim from package
Neovim has been added to a Ubuntu PPA. For more information check
[neovim/neovim](https://github.com/neovim/neovim/wiki/Installing-Neovim#ubuntu).
```sh
    sudo apt-get install software-properties-common
    sudo add-apt-repository ppa:neovim-ppa/unstable
    sudo apt-get update
    sudo apt-get install neovim
```

Create a symlink to our config-folder for Neovim:
```sh
    ln -s ~/.vim ~/.config/nvim
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
```
If you like, you can set up an alias for `nvim`:
```sh
    echo "alias 'vi'='nvim '" >> ~/.bashrc
```
Now reload the bash-settings:
```sh
    source ~/.bashrc
```

And create a symlink to our config-folder for Neovim:
```sh
    ln -s ~/.vim ~/.config/nvim
```

### Make Python available in Neovim
Test whether Neovim is able to use Python:
```sh
    nvim
    :python print "hello"
```

If this does not work, you can install the Python package `neovim` manually.
For more information you can check the Neovim documentation on
[Python in Neovim](https://neovim.io/doc/user/nvim_python.html).
```sh
    sudo apt-get install python-dev python-pip
    sudo pip2 install neovim
```

Typically `/usr/bin` contains a symbolic link `python2` to the latest Python 2 version.
If there is no such symlink, you have to change the path in `vimrc:line19`.
```vim
    let g:python_host_prog = '/path/to/your/python2'
```

### Install vim plugins
Among other things, `vim-plug` can easily manage vim-plugins that are available on github.
It is already contained in this .vim-folder and does not need to be installed manually.
For more information see [jungeunn/vim-plug](https://github.com/junegunn/vim-plug).

To use YouCompleteMe, make sure you have at the latest Vim 7.3.598 with python2 support.
For more information on how to install YCM check
[Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-installation).
```sh
    sudo apt-get install build-essential cmake
    sudo apt-get install python-dev
```

Now you can restart vim to reload .vimrc and enter `:PlugInstall` to
automagically install all plugins listed in the `vimrc` via `vim-plug`.
YouCompleteMe is automatically compiled using Python 2 at the end of calling `:PlugInstall`.
