" Entry point for :Scratch command
function! scratch_buffer#ScratchBuffer() abort
    vnew
    setlocal buftype=nofile bufhidden=hide
endfunction
