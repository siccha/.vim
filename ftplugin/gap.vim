" Only do this when not done yet for this buffer
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

" Load the GAPWORDS file for use with YCM when the first gap-file is read
if !exists("s:loaded_GAPWORDS")
  badd ~/.vim/GAPWORDS
endif
let s:loaded_GAPWORDS = 1
