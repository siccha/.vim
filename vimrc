" Originally from:
" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" Some Linux distros have filetype on in the system vimrc. Turn filetype
" detection off and, even if it's not strictly necessary, disable loading of
" indent scripts and filetype plugins for now
filetype off
filetype plugin indent off

" use the correct python version
let g:python_host_prog = '/usr/bin/python2'

"-----------------------------------------------------------------------------
" vim-plug settings
" make sure you use single quotes
call plug#begin()

" This lets vim-plug call the python 2 script `install.py` to build YCM
" Check the README.md for system dependencies (i.e. apt-get repositories)
function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    "--clang-completer " you can add this option if you want semantic C support
    !python2 ./install.py
  endif
endfunction

"-----------------------------------------------------------------------------
" Must have plugins
" Provides tab completion. For system packages that need to be installed see
" the README.md.
Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Provides code snippets. This plugin is VERY customizable and you
" SHOULD at least have a look at the basic tutorials (2 - 10 minutes).
" For links to the tutorials, see the file README.md.
Plug 'SirVer/ultisnips'
" Fixes all kinds of vulnerabilities related to modelines
Plug 'ciaranm/securemodelines'
" Provides a helpful status line (the thing at the bottom)
Plug 'vim-airline/vim-airline'
" Ctags
Plug 'preservim/tagbar'
"-----------------------------------------------------------------------------
" Nice to have plugins
" If vim-fugitive is the Git, vim-rhubarb is the Hub.
Plug 'tpope/vim-rhubarb'
" Alternative for project drawer, that is for browsing the project file tree
Plug 'tpope/vim-vinegar'
" Creates matching closing parantheses, brackets etc.
Plug 'Raimondi/delimitMate'
" Use gcc and gc<motion> to comment using commentstring
Plug 'tpope/vim-commentary'
" Enables e.g. latex files to be compiled in the background
Plug 'neomake/neomake'
" Let commands run asynchronously
Plug 'tpope/vim-dispatch'
" Use neovim terminal emulator for vim-dispatch
Plug 'radenling/vim-dispatch-neovim'
" Provides an awesome Git-wrapper for vim
Plug 'tpope/vim-fugitive'
" Defines some useful shortcuts like `[c` and `]c` for walking through
" diffs in a diff view (e.g. when inspecting merge conflicts)
Plug 'tpope/vim-unimpaired'
" Makes motions like `[`/`]` but also `[c`/`]c` repeatable.
Plug 'vim-scripts/repeatable-motions.vim'
" TabooRename lets you choose display names for your tabs
Plug 'gcmt/taboo.vim'
" Unicode completion and search
Plug 'chrisbra/unicode.vim'
" Support for the emacs orgmode
Plug 'jceb/vim-orgmode'
"-----------------------------------------------------------------------------
" Language support
Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'
"-----------------------------------------------------------------------------
" Plugins to try
" Git.wincent.com/command-t.git
" Kien/ctrlp. Vim
" Terryma/vim-multiple-cursors
"-----------------------------------------------------------------------------

" Add plugins to &runtimepath
call plug#end()


"-----------------------------------------------------------------------------
" neovim specific settings
" Let combinations of alt with other keys send an ESC key first.
" Thus pressing e.g. <A-j> can be used to exit insert mode.
" This behaviour is a standard 'feature' in vanilla vim.
if has('nvim')
    let s:printable_ascii = map(range(32, 126), 'nr2char(v:val)')
    call remove(s:printable_ascii, 92)
    for s:char in s:printable_ascii
        execute "inoremap <A-" . s:char . "> <Esc>" . s:char
    endfor
    unlet s:printable_ascii s:char
endif

" to use color schemes with nvim set the environment variable
" TERM=xterm-256color


"-----------------------------------------------------------------------------
" Must have options
"-----------------------------------------------------------------------------
"
" These are highly recommended options.

" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden

" Better command-line completion
set wildmenu
" First tab completes to longest common prefix. Afterwards tabs cycle full
" completions.
set wildmode=longest:full,full

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch


"-----------------------------------------------------------------------------
" Usability options
"-----------------------------------------------------------------------------
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype plugin on
filetype indent off

" Enable syntax highlighting
syntax on

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled
set autoindent

" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set relativenumber
set number

" Quickly time out on keycodes, but never time out on mappings
" I took this from the internet. Is this for ssh connections?
"set notimeout ttimeout ttimeoutlen=200

" Keep 5 lines above and below cursor on screen:
set scrolloff=5

"-----------------------------------------------------------------------------
" Indentation options
set shiftwidth=4
set softtabstop=4
set expandtab

"-----------------------------------------------------------------------------
" Diff-Mode options
" Highlighting
highlight DiffText ctermbg=White

"-----------------------------------------------------------------------------
" Disable plaintex and context filetypes for *.tex files
let g:tex_flavor = "latex"


"-----------------------------------------------------------------------------
" Plug-In configurations
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" YouCompleteMe configuration
let g:ycm_collect_identifiers_from_tags_files = 1

"-----------------------------------------------------------------------------
" delimitMate configuration
" also see Auto Commands
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1

" delimitMate: Insert ";" at EOL for the given filetypes
au FileType c,gap,magma,rust let b:delimitMate_insert_eol_marker = 1
au FileType c,gap,magma,rust let b:delimitMate_eol_marker = ";"

"-----------------------------------------------------------------------------
" vim-fugitive configuration
" Opening a git object using fugitive creates a new buffer.
" This autocommand deletes unused buffers.
autocmd BufReadPost fugitive://* set bufhidden=delete

"-----------------------------------------------------------------------------
" UltiSnips configuration
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-j>"
let g:UltiSnipsJumpForwardTrigger="<A-l>"
let g:UltiSnipsJumpBackwardTrigger="<A-h>"
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnips']
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"

"-----------------------------------------------------------------------------
" Neomake configuration
" Neomake populates the quickfix list.
" 'remove_invalid_entries' = 1
" makes it ignore every line that doesn't match 'errorformat'
let g:neomake_make_maker = {
    \ 'remove_invalid_entries': 1,
    \ }
" Opens the quickfix list if errors occur
let g:neomake_open_list=1
" Use our custom configuration for `make`
let g:neomake_enabled_makers=['make']

"-----------------------------------------------------------------------------
" Tagbar Settings
"-----------------------------------------------------------------------------
let g:tagbar_type_gap = {
    \ 'ctagstype' : 'gap',
    \ 'kinds' : [
        \ 'f:function',
        \ 'v:value',
        \ 'm:method',
        \ 't:truemethod',
        \ 'd:documentation',
        \ 'c:category',
        \ 'r:representation',
        \ 'i:infoclass',
        \ 'a:attribute',
        \ 'p:property',
        \ 's:synonym',
        \ 'g:gfunction',
        \ 'o:operation'
    \ ]
\ }

"-----------------------------------------------------------------------------
" Taboo settings
" Remember tab names when you save the current session
set sessionoptions+=tabpages,globals

"-----------------------------------------------------------------------------
" Miscellanous fixes
" These will probably be incorporated into fugitive at some point in time
"-----------------------------------------------------------------------------
" Fix for fugitive `Gpush` freezing under neovim
if (len($SECURITYSESSIONID) || len($DISPLAY)) && empty($SSH_ASKPASS)
  let s:gui_askpass = system("git --exec-path")[0:-2] . "/git-gui--askpass"
  if executable(s:gui_askpass)
    let $SSH_ASKPASS = s:gui_askpass
  elseif executable("ssh-askpass")
    let $SSH_ASKPASS = "ssh-askpass"
  endif
endif

"-----------------------------------------------------------------------------
" Read further settings
"-----------------------------------------------------------------------------
" `runtime` is the relative version of `source`. It searches in 'runtimepath'
" specified directories for files to include.
" Generally useful mappings should go here
runtime public_mappings
" My personal maps. Create this symbolic link to the file vimrc_private to
" enable the personal maps
runtime link_to_private_mappings
