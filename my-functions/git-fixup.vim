nnoremap <leader>gfi :set operatorfunc=<SID>MyGfixup<cr>g@
vnoremap <leader>gfi :<c-u>call <SID>MyGfixup(visualmode())<cr>
" need a version which does not do operator stuff
"command! -nargs=1 MyGfixup :call <SID>MyGfixup(<q-args>)

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
