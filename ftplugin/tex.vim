" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Let :Neomake! be executed on each write
if !exists("s:latex_auto_make")
  au BufWritePost * Neomake!
endif
let s:latex_auto_make = 1

" Make this one work only in tex files
if !exists("s:override_tab")
  inoremap <Tab> \
endif
let s:override_tab = 1
