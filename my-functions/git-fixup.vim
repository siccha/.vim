nnoremap <leader>gff :set operatorfunc=<SID>MyGfixup<cr>g@
vnoremap <leader>gff :<c-u>call <SID>MyGfixup(visualmode())<cr>

function! s:MyGfixup(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[y`]"
    else
        return
    endif
    execute ":Gcommit"
    call append(0, @@)
    normal! kIfixup! 
    let @@ = saved_unnamed_register
endfunction
