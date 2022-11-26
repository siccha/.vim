"set foldmethod=indent
if exists("b:did_ftplugin")
  finish
endif
let b:did_ftplugin = 1

setlocal textwidth=0
setlocal commentstring=#%s
