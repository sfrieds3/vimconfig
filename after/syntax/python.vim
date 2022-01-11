syn match pythonFunctionCall '\%([^[:cntrl:][:space:][:punct:][:digit:]]\|_\)\%([^[:cntrl:][:punct  :][:space:]]\|_\)*\ze\%(\s*(\)'   

syn region pythonFCall matchgroup=pythonFName start='[[:alpha:]_]\i*\s*(' end=')' contains=pythonF  Call,pythonFCallKeyword   
syn match pythonFCallKeyword /\i*\ze\s*=[^=]/ contained
hi link pythonFCallKeyword Label
hi link pythonFName Tag
