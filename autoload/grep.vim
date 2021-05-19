if exists('g:loaded_grep')
    finish
endif
let g:loaded_grep = 1

function! grep#Grep(...)
    return system(join([&grepprg] + [a:1] + [expandcmd(join(a:000[1:-1], ' '))], ' '))
endfunction
