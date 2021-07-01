nnoremap <leader>rg :set operatorfunc=<SID>GrepOperator<cr>g@
vnoremap <leader>rg :<c-u>call <SID>GrepOperator(visualmode())<cr>

function! s:GrepOperator(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[y`]"
    else
        return
    endif
    silent execute "grep! -R "
        \ . "--exclude-dir=\.git --exclude-dir=\.venv "
        \ . "--exclude-dir=plugged "
        \ . shellescape(@@) . " ."
    copen
    let @@ = saved_unnamed_register
endfunction
