nnoremap <leader>gss :set operatorfunc=<SID>MyGitshow<cr>g@iw

nnoremap <leader>gii :set operatorfunc=<SID>MyGfixup<cr>g@iw
vnoremap <leader>gii :<c-u>call <SID>MyGfixup(visualmode())<cr>:wq<CR>
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
    execute ":Git commit --fixup=" .. @@
    " normal! gg
    " call append(0, @@)
    " normal! kIfixup! 
    let @@ = saved_unnamed_register
endfunction


function! s:MyGitshow(type)
    let saved_unnamed_register = @@
    if a:type ==# 'v'
        execute "normal! `<v`>y"
    elseif a:type ==# 'char'
        execute "normal! `[y`]"
    else
        return
    endif
    execute ":Git show " .. @@
    " normal! gg
    " call append(0, @@)
    " normal! kIfixup! 
    let @@ = saved_unnamed_register
endfunction
