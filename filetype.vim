" my filetype file
"did_load_filetypes is set automatically
if exists("did_load_filetypes")
  finish
endif
augroup filetypedetect
  au! BufRead,BufNewFile *.g         setfiletype gap
  au! BufRead,BufNewFile *.gi        setfiletype gap
  au! BufRead,BufNewFile *.gd        setfiletype gap
  au! BufRead,BufNewFile *.autodoc   setfiletype autodoc
  au! BufRead,BufNewFile *.bug       setfiletype bug
  au! BufRead,BufNewFile *.m         setfiletype magma
augroup END
