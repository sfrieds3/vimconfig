if exists('g:loaded_whitespace')
    finish
endif
let g:loaded_whitespace = 1

" returns an extranous 0...
function! whitespace#StripTrailingWhitespace() range
    if !&binary && &filetype != 'diff'
        execute "redir => numclean"
        silent! execute "%s/\\s\\+$//en"
        execute "redir END"
        silent! call preserve#Preserve(":%s/\\s\\+$//e")
        if strlen(numclean) >0
            execute 'echo substitute(numclean, "\n", "", "g")'
        else
            execute 'echo "No trailing whitespace..."'
        endif
    endif
endfunction
