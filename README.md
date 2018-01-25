### Setup vim configuration
Get the `.vim` folder:
```sh
    git clone https://github.com/ssiccha/.vim.git ~/.vim
```

### Install vim plugins
Among other things, `vim-plug` can easily manage vim-plugins that are available on github.
It is already contained in this .vim-folder and does not need to be installed manually.
For more information see [junegunn/vim-plug](https://github.com/junegunn/vim-plug).

To use YouCompleteMe, use `vim --version` to make sure you have Vim 7.3.598 or later with python2 support.
For more information on YCM see
[Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-installation).

Install the prerequisites to compile YCM:
```sh
    sudo apt-get install build-essential cmake python-dev
```

Now open / restart vim to load / reload the vimrc and enter `:PlugInstall` to
let `vim-plug` install all plugins listed in the `vimrc` via `Plug 'link-to-github-repo'`.
YouCompleteMe is automatically compiled using Python2 after calling `:PlugInstall`.
This may take some time. Now restart vim again.


Some Terminals use even less than 256 colors as standard setting. Setup `bash` accordingly:
```sh
    echo '#Set TERM:' >> ~/.bashrc
    echo 'export TERM="xterm-256color"' >> ~/.bashrc
    source ~/.bashrc
```

### Install neovim
For information on how to install neovim see the `NEOVIM.md`.
