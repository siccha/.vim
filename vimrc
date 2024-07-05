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
let g:python3_host_prog = '/opt/homebrew/bin/python3'

"-----------------------------------------------------------------------------
" vim-plug settings
" Recommended with neovim is to use the folder $HOME/.local/share/nvim/ and
" there
" - site/autoload/plug.vim
" - plugged/  <- package folders go here
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

function! BuildCodeWhisperer(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !cat ~/.local/share/nvim/plugged/AmazonCodeWhispererVimPlugin/service-2.json | jq '.metadata += {"serviceId":"codewhisperer"}' | tee /tmp/aws-coral-model.json && aws configure add-model --service-model file:///tmp/aws-coral-model.json --service-name codewhisperer
  endif
endfunction

"-----------------------------------------------------------------------------
" Must have plugins
" Provides tab completion. For system packages that need to be installed see
" the README.md.
" Try nvim-cmp instead of YCM
"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'lukas-reineke/cmp-rg'
" For luasnip users.
" Plug 'L3MON4D3/LuaSnip'
" Plug 'saadparwaiz1/cmp_luasnip'
" For ultisnips users.
" Plug 'quangnguyen30192/cmp-nvim-ultisnips'
" Provides code snippets. This plugin is VERY customizable and you
" SHOULD at least have a look at the basic tutorials (2 - 10 minutes).
" For links to the tutorials, see the file README.md.
" Plug 'SirVer/ultisnips'
" Fixes all kinds of vulnerabilities related to modelines
Plug 'ciaranm/securemodelines'
" Provides a helpful status line (the thing at the bottom)
Plug 'vim-airline/vim-airline'
" Ctags
Plug 'preservim/tagbar'
" Linters
" Black for python
Plug 'psf/black', { 'branch': 'stable' }
" Isort for python
Plug 'fisadev/vim-isort'
" Ale for running JS prettier and maybe eslint
Plug 'dense-analysis/ale'
"-----------------------------------------------------------------------------
" Nice to have plugins
" CodeWhisperer: https://code.amazon.com/packages/AmazonCodeWhispererVimPlugin
" Depends on: https://code.amazon.com/packages/AmazonCodeWhispererPythonClient
"Plug 'ssh://git.amazon.com/pkg/AmazonCodeWhispererVimPlugin', { 'do': function('BuildCodeWhisperer') }
Plug 'ssh://git.amazon.com/pkg/AmazonCodeWhispererVimPlugin'
" If vim-fugitive is the Git, vim-rhubarb is the Hub.
Plug 'tpope/vim-rhubarb'
" Alternative for project drawer, that is for browsing the project file tree
Plug 'tpope/vim-vinegar'
" Creates matching closing parantheses, brackets etc.
"Plug 'Raimondi/delimitMate'
Plug 'windwp/nvim-autopairs'
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
" I think this screws up gitsigns as soon as the gitsign column disappears
" because e.g. I staged or reset all hunks
" Plug 'vim-scripts/repeatable-motions.vim'
" TabooRename lets you choose display names for your tabs
Plug 'gcmt/taboo.vim'
" Unicode completion and search
Plug 'chrisbra/unicode.vim'
" Send buffer contents to a terminal
Plug 'jpalardy/vim-slime'
" Jump to any location specified by two characters
Plug 'justinmk/vim-sneak'
" Custom text-objects, dependecy of vim-textobj-underscore
Plug 'kana/vim-textobj-user'
" civ and cav = change inside snake_case, CamelCase and smallCamelCase
Plug 'Julian/vim-textobj-variable-segment'
" text object ij/aj for innermost of either (, [, {
Plug 'Julian/vim-textobj-brace'
" text object iq/aq for innermost quote
Plug 'beloglazov/vim-textobj-quotes'
" text object ir/ar for indention based paragraph
Plug 'pianohacker/vim-textobj-indented-paragraph'
" Signcolumn markers, stage from within buffer and much more
Plug 'lewis6991/gitsigns.nvim'
Plug 'tmhedberg/SimpylFold'
" Simple, no-hassle Vim sessions
Plug 'tpope/vim-obsession'
" <C-A> and <C-X> for dates
Plug 'tpope/vim-speeddating'
" Dependency of vim-markdown
Plug 'godlygeek/tabular'
" Syntax highlighting, matching rules and mappings for the original Markdown and extensions.
Plug 'preservim/vim-markdown'
" show the buffer name in non-focused windows
Plug 'ldelossa/buffertag'
" Changing and adding surrounding delimiters
Plug 'kylechui/nvim-surround'
"-----------------------------------------------------------------------------
" language support
Plug 'JuliaEditorSupport/julia-vim'
Plug 'rust-lang/rust.vim'
" configs for Language Server Protocol - LSP
Plug 'neovim/nvim-lspconfig'
"-----------------------------------------------------------------------------
" Plugins to try
" Fold preview plus dependecy
Plug 'anuvyklack/keymap-amend.nvim'
Plug 'anuvyklack/fold-preview.nvim'
" Support for the emacs orgmode
Plug 'jceb/vim-orgmode'
" Git.wincent.com/command-t.git
" Kien/ctrlp. Vim
" Terryma/vim-multiple-cursors
" Telescope is a highly extendable fuzzy finder over lists.
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
" Telescope dependencies
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
"Plug 'nvim-telescope/telescope-fzy-native.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'kyazdani42/nvim-web-devicons'
" repeat gitsigns commands
Plug 'tpope/vim-repeat'
" Folds
Plug 'Konfekt/FastFold'
" vscode-like pictograms for completion menu
Plug 'onsails/lspkind.nvim', {'branch': 'master' }
" Reimagine organization
" Might have to do :Neorg sync-parsers
Plug 'nvim-neorg/neorg'
" Plug 'mbbill/undotree'
Plug 'ellisonleao/gruvbox.nvim'
Plug 'shaunsingh/solarized.nvim'
Plug 'shaunsingh/moonlight.nvim'
Plug 'shaunsingh/nord.nvim'
"  Clean and elegant distraction-free writing for NeoVim 
Plug 'Pocco81/true-zen.nvim'
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

" When a file has been detected to have been changed outside of Vim and
" it has not been changed inside of Vim, automatically read it again.
" When the file has been deleted this is not done.
set autoread

" Sets 'foldlevel' when starting to edit another buffer in a window.
set foldlevelstart=1

let g:vim_markdown_folding_disabled = 1

set conceallevel=2

" Remove coloured background from folding
hi! link Folded Normal

" disable split resizing after closing or splitting
set noequalalways

" Removes status lines on each window, instead use buffertag plugin
set laststatus=3

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

" Influences color theme.
" bg = background
set background=dark
colorscheme moonlight

"------------------------------------------------------------
" Make vsplit put the new buffer on the right side
set splitright

" Make split put the new buffer below
set splitbelow

"------------------------------------------------------------
" Formatting options
"------------------------------------------------------------
" Settings to wrap text automatically
" textwidth is used as the max line length when wrapping
" set textwidth=79
"   t automatic line wrapping in text
"   c automatic line wrapping in comments
"   r insert comment leader when hitting <ENTER> in insert mode
set formatoptions+=tcr
"   o insert comment leader when hitting 'o' or 'O' in normal mode
set formatoptions-=o 

" Terminal options
" how many lines are kept as scrollback
set scrollback=50000

"------------------------------------------------------------
" Highlighting
"------------------------------------------------------------
" Highlights trailing whitespace
match Todo /\s\+$/

"-----------------------------------------------------------------------------
" Plug-In configurations
"-----------------------------------------------------------------------------

"-----------------------------------------------------------------------------
" vim-airline
" Don't show encoding, errors, and warnings in the status line
let g:airline#extensions#default#layout = [
    \ [ 'a', 'b', 'c' ],
    \ [ 'x', 'z' ]
    \ ]
" TODO Need to use tabline to have this?
let g:airline#extensions#tabline#buffer_nr_show = 1

"-----------------------------------------------------------------------------
" Black
let g:black_linelength = 100

" Ale
let g:ale_fix_on_save = 1
"-----------------------------------------------------------------------------
" Slime
let g:slime_target = "neovim"

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

" Black configuration
" python-lsp-black plugin should integrate with pylsp
augroup black_on_save
  autocmd!
  autocmd BufWritePre *.py execute 'Black' | execute 'Isort'
augroup end

augroup source_dispatch_on_write
  autocmd!
  autocmd BufWritePost dispatch.vim source dispatch.vim
augroup end
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

" restore_view: Don't let :mkview save too many things.
" Instead of putting this into a plugin, I put it into
" my-functions/restore-view.vim
set viewoptions=cursor,folds

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
" Lua
" Plugins to try
lua require('buffertag').enable()
lua require('fold-preview').setup()

lua require('telescope').setup()
"lua require('telescope').load_extension('fzf')
" From the fzf installation logs:
" To install useful keybindings and fuzzy completion:
"   /opt/homebrew/opt/fzf/install
" To use fzf in Vim, add the following line to your .vimrc:
"   set rtp+=/opt/homebrew/opt/fzf


lua << EOF
require('gitsigns').setup{
  sign_priority = 100,
  watch_gitdir = {
    interval = 250,
    follow_files = true
  },
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then return ']c' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    map('n', '[c', function()
      if vim.wo.diff then return '[c' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, {expr=true})

    -- Actions
    map({'n', 'v'}, '<leader>hs', ':Gitsigns stage_hunk<CR>')
    map({'n', 'v'}, '<leader>hr', ':Gitsigns reset_hunk<CR>')
    map('n', '<leader>hS', gs.stage_buffer)
    map('n', '<leader>hu', gs.undo_stage_hunk)
    map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>hp', gs.preview_hunk)
    map('n', '<leader>hb', function() gs.blame_line{full=true} end)
    map('n', '<leader>tb', gs.toggle_current_line_blame)
    map('n', '<leader>hd', gs.diffthis)
    map('n', '<leader>hD', function() gs.diffthis('~') end)
    map('n', '<leader>td', gs.toggle_deleted)

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end
}
EOF

" Short setup calls
lua require('nvim-autopairs').setup{}
"-----------------------------------------------------------------------------
" Python development
" Enable docstring preview in fold text
let g:SimpylFold_docstring_preview = 1
let g:SimpylFold_fold_docstring = 0

"-----------------------------------------------------------------------------
" nvim-cmp configuration from:
" https://github.com/hrsh7th/nvim-cmp
set completeopt=menu,menuone,noselect
lua <<EOF
local lspkind = require('lspkind')
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

-- Setup nvim-cmp.
local cmp = require'cmp'

cmp.setup({
  snippet = {
    -- REQUIRED - you must specify a snippet engine
    expand = function(args)
      -- vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      -- require('snippy').expand_snippet(args.body) -- For `snippy` users.
      -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
    end,
  },
  window = {
    -- completion = cmp.config.window.bordered(),
    -- documentation = cmp.config.window.bordered(),
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      --elseif vim.fn["vsnip#available"](1) == 1 then
      --  feedkey("<Plug>(vsnip-expand-or-jump)", "")
      elseif has_words_before() then
        cmp.complete()
      else
        fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
      end
    end, { "i", "s" }),
    ["<S-Tab>"] = cmp.mapping(function()
      if cmp.visible() then
        cmp.select_prev_item()
      --elseif vim.fn["vsnip#jumpable"](-1) == 1 then
      --  feedkey("<Plug>(vsnip-jump-prev)", "")
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lsp_signature_help' },
    { name = 'nvim_lua' },
    -- { name = 'vsnip' }, -- For vsnip users.
    -- { name = 'luasnip' }, -- For luasnip users.
    -- { name = 'ultisnips' }, -- For ultisnips users.
    -- { name = 'snippy' }, -- For snippy users.
    { name = 'path' },
  }, {
    { name = 'buffer' },
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = "symbol_text",
      menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[Latex]",
      })
    }),
  },
})

  -- Set configuration for specific filetype.
  cmp.setup.filetype('gitcommit', {
    sources = cmp.config.sources({
      -- { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
    }, {
      { name = 'buffer' },
    })
  })

  -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline('/', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = {
      { name = 'buffer' }
    }
  })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  cmp.setup.cmdline(':', {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources({
      { name = 'path' }
    }, {
      { name = 'cmdline' }
    })
  })
EOF

" nvim-lspconfig mappings
" automatically hover on hover
" autocmd CursorHold  <buffer> lua vim.lsp.buf.hover()
" trigger CursorHold after X ms
" set updatetime=4000
lua <<EOF
-- Mappings.
-- https://github.com/neovim/neovim/issues/14825#issuecomment-1017482249
vim.g.diagnostics_visible = true
function _G.toggle_diagnostics()
  if vim.g.diagnostics_visible then
    vim.g.diagnostics_visible = false
    vim.diagnostic.disable()
  else
    vim.g.diagnostics_visible = true
    vim.diagnostic.enable()
  end
end
-- hld : h = Gitsigns, l = lsp, d = diagnostics
vim.api.nvim_set_keymap('n', '<Leader>hld', ':call v:lua.toggle_diagnostics()<CR>', {silent=true, noremap=true})

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>k', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<c-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  -- Previously I set this to 'lua vim.lsp.buf.rename()<CR><C-F>0'. That doesn't work anymore.
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- TODO try this, it looks super cool!
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>lf', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
end


-- Setup lspconfig.
-- map buffer local keybindings when the language server attaches
local capabilities = require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())
local util = require("lspconfig/util")
require('lspconfig')['pylsp'].setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
      return util.root_pattern(".git", "setup.py",  "setup.cfg", "pyproject.toml", "requirements.txt")(fname) or
        util.path.dirname(fname)
  end,
  settings = {
      pylsp = {
          plugins = {
              pycodestyle = {
                  maxLineLength = 100,
              },
              jedi = {
                  extra_paths = {
                      "/Volumes/workplace/AGITaskLibrary/src/AGIMLOpsCommonTaskLibrary/src/",
                      "/Volumes/workplace/AGIWorkflow/src/AGIWorkflowServiceLambda/src/",
                      "/Volumes/workplace/asr-workspace/build-clouddesktop/brazil-pkg-cache/Dory/Dory-1.4.13465.0/AL2_x86_64/DEV.STD.PTHREAD/build/lib/python3.6/site-packages",
                      -- "/Volumes/workplace/asr-workspace/src/Dory/",
                      "/Volumes/workplace/AlexaAsrDailyLMUpdate/src/AlexaAsrDailyLMUpdate/src",
                      "/Volumes/workplace/phasa_ws/src/AlexaAsrDailyLMUpdate/src",
                      "/Volumes/workplace/pyrama/build-clouddesktop/",
                      "/Volumes/workplace/asr-workspace/src/MetadoryPOC/src/",
                      "/Volumes/workplace/asr-workspace/src/AlexaAsrUberRecipe/src/",
                      "/Volumes/workplace/asr-workspace/src/Dory-BlueShift-Speech/lib/",
                      "/Volumes/workplace/asr-workspace/src/Dory-BlueShift-Speech/recipes/",
                      "/Volumes/workplace/asr-workspace/build-clouddesktop/Dory-BlueShift-Speech/Dory-BlueShift-Speech-1.0/AL2_x86_64/DEV.STD.PTHREAD/build/lib/python3.6/site-packages",
                  },
              },
          },
      },
  },
}

require('lspconfig').rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require'lspconfig'.tsserver.setup{
    on_attach = on_attach,
    capabilities = capabilities,
}

-- Setup nvim-surround
require("nvim-surround").setup()

-- Treesitter
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
    -- "lua"
    -- To be able to install neorg Treesitter parser on MacOS check https://github.com/nvim-neorg/neorg#troubleshooting-treesitter
    -- Install llvm and use its clang compiler
  ensure_installed = { "help", "rust", "norg" },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- Automatically install missing parsers when entering buffer
  -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
  auto_install = true,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "javascript" },

  ---- If you need to change the installation directory of the parsers (see -> Advanced Setup)
  -- parser_install_dir = "/some/path/to/store/parsers", -- Remember to run vim.opt.runtimepath:append("/some/path/to/store/parsers")!

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
        local max_filesize = 100 * 1024 -- 100 KB
        local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
            return true
        end
    end,
    disable = { "c", "rust" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

-- Neorg
require('neorg').setup {
    load = {
        ["core.defaults"] = {},
        ["core.norg.dirman"] = {
            config = {
                workspaces = {
                    work = "~/Documents/work",
                    home = "~/Documents/private",
                }
            }
        },
        ["core.norg.concealer"] = {},
        -- Needs setup?
        ["core.norg.completion"] = {
            config = {
                engine = "nvim-cmp"
            }
        },
        -- Needs setup?
        -- ["core.gtd.base"] = {},
    }
}

-- Undotree
-- vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, {})

EOF
"   core.presenter - Neorg module to create gorgeous presentation slides.
"   core.gtd.base - Manages your tasks with Neorg using the Getting Things Done methodology.
"   core.export.markdown - Interface for core.export to allow exporting to markdown.
"   core.export - Exports Neorg documents into any other supported filetype.
"   core.norg.dirman - This module is be responsible for managing directories full of .norg files.
"   core.norg.completion - A wrapper to interface with several different completion engines.
"   core.norg.concealer - Enhances the basic Neorg experience by using icons instead of text.
"   core.norg.manoeuvre - A Neorg module for moving around different elements up and down.

"-----------------------------------------------------------------------------
" Read further settings
"-----------------------------------------------------------------------------
" `runtime` is the relative version of `source`. It searches in 'runtimepath'
" specified directories for files to include.
runtime mappings
" Make bash aliases visible to vim
let $BASH_ENV = "~/.vim_bash_env"
source ~/.amazon_config/vimrc
"-----------------------------------------------------------------------------
" Custom operators
runtime! my-functions/*.vim
