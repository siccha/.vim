" my filetype file
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.g         setfiletype gap
  au! BufRead,BufNewFile *.gi        setfiletype gap
augroup END
