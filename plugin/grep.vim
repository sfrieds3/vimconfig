command! -nargs=+ -complete=file_in_path -bar Grep cgetexpr grep#Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr grep#Grep(<f-args>)
