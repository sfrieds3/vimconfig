" do not include ':' as part of word
setlocal iskeyword-=:

setlocal shiftwidth=2 softtabstop=2 tabstop=2 expandtab

setlocal foldmethod=indent nofoldenable

if exists("g:pl_formatprg")
    let &l:formatexpr=expand(g:pl_formatprg)
else
    let &l:formatexpr='perltidy\ -st'
endif

if exists("g:pl_makeprg")
    " e.g. let g:pl_makeprg='perl\c -c'
    execute "setlocal makeprg=" . g:pl_makeprg
else
    setlocal makeprg='perl\ -c'
endif

setlocal equalprg='perltidy\ -st'

" settings for vim-perl
"let g:perl_include_pod = 1
"let g:perl_no_scope_in_variables = 0
"let g:perl_no_extended_vars = 0

" undo changes
let b:undo_ftplugin = "setlocal sw< sts< ts< fdm< fen< isk< mp< et< ep<"
