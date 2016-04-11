" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible

" some Linux distros have filetype on in the system vimrc
" turn filetype detection off and, even if it's not strictly
" necessary, disable loading of indent scripts and filetype plugins
filetype off
filetype plugin indent off

" use the correct python version
let g:python_host_prog = '/usr/bin/python2'

"------------------------------------------------------------
" vim-plug settings
" make sure you use single quotes
call plug#begin()

function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !python2 ./install.py --clang-completer
  endif
endfunction

Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" Plug 'Valloric/YouCompleteMe'
Plug 'bkad/CamelCaseMotion'
Plug 'Raimondi/delimitMate'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ciaranm/securemodelines'
Plug 'majutsushi/tagbar'
Plug 'SirVer/ultisnips'
Plug 'vim-airline/vim-airline'

" Add plugins to &runtimepath
call plug#end()


"------------------------------------------------------------
" neovim settings
" let alt 'send' ESC key
let s:printable_ascii = map(range(32, 126), 'nr2char(v:val)')
call remove(s:printable_ascii, 92)
for s:char in s:printable_ascii
    execute "inoremap <A-" . s:char . "> <Esc>" . s:char
endfor
unlet s:printable_ascii s:char

" to use vim's color scheme set the environment variable
" TERM=xterm-256color

"------------------------------------------------------------
" Pathogen settings
"
" To disable a plugin, add it's bundle name to the following list
" let g:pathogen_disabled = ['supertab']

" execute pathogen#infect()
" call pathogen#runtime_append_all_bundles() # deprecated
" call pathogen#helptags() " too crazy
" set rtp+=~/.vim/bundle/YouCompleteMe
" runtime plugin/youcompleteme.vim


"------------------------------------------------------------
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on

" Enable syntax highlighting
syntax on


"------------------------------------------------------------
" Must have options {{{1
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

" Show partial commands in the last line of the screen
set showcmd

" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch

" Using the securemodelines script
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
" see securemodelines plug-in

"------------------------------------------------------------
" Usability options {{{1
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

" Always display the status line, even if only one window is displayed
" set laststatus=2

" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" Use visual bell instead of beeping when doing something wrong
set visualbell

" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
" set t_vb=

" Enable use of the mouse for all modes
set mouse=a

" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2

" Display line numbers on the left
set relativenumber
set number

" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200

" Keep 5 lines above and below cursor on screen:
set scrolloff=5

"" Highlight current line:
"hi CursorLine term=none cterm=none ctermbg=16 ctermfg=none
"hi CursorColumn term=none cterm=none ctermbg=16 ctermfg=none
"" but only if the cursor does not move:
"autocmd CursorHold,CursorHoldI * set cursorline
"autocmd CursorMoved,CursorMovedI * set nocursorline
"autocmd CursorHold,CursorHoldI * set cursorcolumn
"autocmd CursorMoved,CursorMovedI * set nocursorcolumn


"------------------------------------------------------------
" Indentation options {{{1
"
set shiftwidth=2
set softtabstop=2
set expandtab


"------------------------------------------------------------
" Disable plaintex and context filetypes for *.tex files
let g:tex_flavor = "latex"


"------------------------------------------------------------
" Plug-In configurations {{{1
"------------------------------------------------------------

"------------------------------------------------------------
" YouCompleteMe configuration
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 0
" GAPWORDS is loaded via ~/bin/vimgapfiles


"------------------------------------------------------------
" delimitMate configuration
let g:delimitMate_expand_space = 1
let g:delimitMate_expand_cr = 1


"------------------------------------------------------------
" UltiSnips configuration
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<C-i>"
let g:UltiSnipsJumpForwardTrigger="<C-j>"
let g:UltiSnipsJumpBackwardTrigger="<C-k>"
let g:UltiSnipsSnippetsDir=$HOME.'/.vim/ultisnips'
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/ultisnips']

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="horizontal"


"------------------------------------------------------------
" nerdtree-git-plugin configuration
let g:NERDTreeGitStatusIgnoreSubmodules = 1


"------------------------------------------------------------
" Auto Commands
"------------------------------------------------------------
" Open NERDTree if no command line args
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Close vim if NERDTree is only window left
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" delimitMate: Insert ";" at EOL for C and GAP files
au FileType c,gap let b:delimitMate_insert_eol_marker = 1
au FileType c,gap let b:delimitMate_eol_marker = ";"


"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
map <C-n> :NERDTreeToggle<CR>
"map <C-h> <C-W>h
"map <C-l> <C-W>l
" <Ctrl-l> redraws the screen and removes any search highlighting.
nnoremap <silent> <C-l> :nohl<CR><C-l>
map <F5> :call GAPlocal()<CR>
" TODO: add scroll hkeys like C-B and C-D (sergio / Mi 13 Jan 2016 10:46:33 CET)

" leader maps
let mapleader=" "
" <leader> w, e, b used by CamelCaseMotion
"
" Buffer mappings
" go to last buffer
map <leader>g :b<space>
map <leader>u :b#<CR>
map <leader>j :bnext<CR>
map <leader>k :bprev<CR>
map <leader>l :buffers<CR>:b<space>

" yank line into system clipboard
map <leader>y <S-V>"+yy

" Map to turn off search highlighting
"nnoremap <C-L> :nohl<CR><C-L>
nnoremap <leader>/ :nohl<CR>

" find InstallMethod, Install... in file
map <leader>f :/Install\w*(\s*
" go to previous local definition
map <leader>o :?local<CR><C-L>
" toggle paste mode
map <leader>p :set paste!<CR>


" unused maps
nmap <F8> :TagbarToggle<CR>
" set wd of current split/tab to this file's dir
" map <C-d> :lcd %:h<CR> " conflicts with scrolling
" map <C-c> :!pdflatex %; pdflatex %<CR> <- only if .tex


" TODO: restrict GapComment, GapLocal to gap-files (sergio / Fr 04 Dez 2015 11:49:08 UTC)


"------------------------------------------------------------
" command abbreviations (renamings) {{{1
cabbrev GW Gw
ca GWQ Gwq
ca QA qa
