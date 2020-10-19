### Setup vim configuration
Get the `.vim` folder:
```sh
    git clone https://github.com/ssiccha/.vim.git ~/.vim
```

### Install vim plugins
Among other things, `vim-plug` can easily manage vim-plugins that are available on github.
It is already contained in this .vim-folder and does not need to be installed manually.
For more information see [junegunn/vim-plug](https://github.com/junegunn/vim-plug).

Install the prerequisites to build the completion engine YCM:
```sh
    sudo apt-get install build-essential cmake python-dev openjdk-11-jre mono npm go
```
For more information on YCM see
[Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-installation).

Now open / restart vim to load / reload the `vimrc` and enter `:PlugInstall` to
let `vim-plug` install all plugins listed in the `vimrc` via `Plug 'link-to-github-repo'`.
YouCompleteMe is automatically compiled after calling `:PlugInstall`.
This may take some time. Now restart vim again.

### How to use this config

`vimrc` contains 
- a list of plugins managed by `vim-plug`.
- usability settings that should be useful for everybody
- plugin configurations
- at the end of the file, it contains inclusion statements of the
`vimrc_mappings` and the `vimrc_private`

`vimrc_mappings` contains
- (leader) mappings that should be useful for everybody. `<SPACE>` is used as
the leader key

`vimrc_private` contains
- my own mappings and settings that not everybody may want. Create a symbolic
link `link_to_vimrc_private` to `vimrc_private` if you want to enable it.


This `vim` configuration is built around the awesome plugins
[Valloric/YouCompleteMe](https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64-installation)
and 
[SirVer/ultisnips](https://github.com/SirVer/ultisnips).
`YCM` is a completion engine whereas `ultisnips` enables you to write your own
code snippets.
To make full use of `ultisnips` you **should** have a look at the amazing, concise
ultisnips tutorials (the first 10 minutes should suffice).
You can find links to SirVer's screencasts on `ultisnips`'
[github repository](https://github.com/SirVer/ultisnips#screencasts)
or watch the screencasts directly on
[YouTube](https://www.youtube.com/watch?time_continue=1&v=Zik6u0klD40).


### Troubleshooting

If you have problems to use / compile YouCompleteMe, make sure that you have Vim 7.3.598 or
later with python2 support (use `vim --version`).
Also, make sure that `python2` is findable via your `$PATH` variable. If it's not, you can e.g.
create a symbolic link via `ln -s /usr/bin/python2.X /usr/bin/python2` to make
it available, where `2.X` is your python version.

If your colours seem to be off, your terminal may be using even less than 256 colors as standard setting.
Setup `bash` accordingly by running this from a terminal:
```sh
    echo '#Set TERM:' >> ~/.bashrc
    echo 'export TERM="xterm-256color"' >> ~/.bashrc
    source ~/.bashrc
```

### Install neovim
For information on how to install neovim see the `NEOVIM.md`.
