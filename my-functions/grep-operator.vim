nnoremap <leader>rg :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>rg :<c-u>call <SID>GrepOperator(visualmode())<cr>

" From https://learnvimscriptthehardway.stevelosh.com/chapters/32.html
function! s:GrepOperator(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[y`]"
    else
        return
    endif
    " TODO: in normal mode (char) this eats the last char of the selection,
    " so adding '\>' at the end breaks it
    silent execute "grep! -R "
        \ . "--exclude-dir=\.git --exclude-dir=\.venv "
        \ . "--exclude-dir=plugged "
        \ . shellescape("\\<") . shellescape(@@) . shellescape("\\>") . " ."
    copen
    let @@ = saved_unnamed_register
endfunction
