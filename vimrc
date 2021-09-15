" vim settings {{{

"use pathogen
if filereadable(glob('$HOME/.vim/autoload/pathogen.vim'))
    execute pathogen#infect('pack/bundle/start/{}')
    execute pathogen#infect('pack/bundle/opt/{}')
    execute pathogen#infect('colors/{}')
    execute pathogen#helptags()
endif

" colorscheme {{{

if !has('nvim')
    augroup CustomizeTheme
        autocmd!
        autocmd ColorScheme * call highlights#MyHighlights()
    augroup END
endif

colorscheme sitrunna

" }}}

" initial settings {{{

filetype plugin indent on

set hidden
set autoread
set nomodeline
set ignorecase
set infercase
set smartcase
set showmatch
set splitbelow
set splitright
set autoindent
set incsearch
set hlsearch

" indentation
set shiftwidth=4
let softtabstop = &shiftwidth
set tabstop=8
set scrolloff=0
set shiftround
set expandtab
set smarttab
" commands for adjusting indentation rules manually
command! -nargs=1 Spaces let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " expandtab"   | silent execute "%!expand -it "  . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?
command! -nargs=1 Tabs   let b:wv = winsaveview() | execute "setlocal tabstop=" . <args> . " noexpandtab" | silent execute "%!unexpand -t " . <args> . "" | call winrestview(b:wv) | setlocal ts? sw? sts? et?

" other setting stuff
set laststatus=2
set backspace=indent,eol,start
set encoding=utf8
set fileencoding=utf8
set showtabline=3
set clipboard^=unnamed,unnamedplus
set foldmethod=manual
set foldcolumn=0
set mouse=a
set formatoptions=qrn1j
set nrformats-=octal
set redrawtime=50000
set showbreak=...

" listchars
set listchars=tab:»\ ,extends:›,precedes:‹,nbsp:␣,trail:·
set list

" do not show listchars in insert
augroup ListChar
    autocmd!
    autocmd InsertEnter * set nolist
    autocmd InsertLeave * set list
augroup END


" allow moving beyond buffer text in visual block
if exists('+virtualedit')
    set virtualedit+=block
endif

" timeout on key codes but not on mappings
set notimeout
set ttimeout
set ttimeoutlen=10

let mapleader = "\\"
let maplocalleader = "_"

" use rg if available, else fall back to git grep  
if executable('rg')  
    set grepprg=rg\ -HS\ --no-heading\ --vimgrep  
    set errorformat^=%f:%l:%c:%m,%f  
else  
    set grepprg=git\ grep\ -in\ $*  
endif

" enable syntax
if !exists("g:syntax_on")
    syntax enable
endif

set wildmenu
set wildignore+=*.pyc
set wildignorecase
set wildcharm=<C-z>
if !has('nvim')
    set wildmode=list:longest,full
endif

set tags=./tags;,tags;

" better completion
set omnifunc=syntaxcomplete#Complete
set complete+=d
set completeopt=longest,menuone,preview

" simple default path
set path=.,,

" use matchit
runtime! macros/matchit.vim

" easy manpages with <leader>K or :Man <manpage>
runtime! ftplugin/man.vim

" cfilter
if has('patch-8.1.0311')
    packadd cfilter
endif

" no ruler by default
if !&ruler
    set ruler
endif

" }}}

" backup settings {{{

set undofile
set backup
set backupext=.bak
set noswapfile

" save lots of history
set viminfo='1000,f1,<1000,/10000,:10000

set undodir=~/.vim/tmp/undo// " undo files
set backupdir=~/.vim/tmp/backup// " backups

" Make those folders automatically if they don't already exist.
if !isdirectory(expand(&undodir))
    call mkdir(expand(&undodir), "p")
endif
if !isdirectory(expand(&backupdir))
    call mkdir(expand(&backupdir), "p")
endif

" }}}

" statusline {{{
" statusline only if more than one buffer
if &laststatus != 2
    set laststatus=2
endif

" toggle statusline
command! ToggleStatusline call statusline#ToggleStatusline()
nnoremap _S :<C-u>:call statusline#ToggleStatusline()<CR>

" toggle ruler
nnoremap _N :<C-u>set ruler! ruler?<CR>
if exists(':xnoremap')
    xnoremap _N :<C-u>set ruler! ruler?<CR>gv
endif

" format the statusline
set statusline=
set statusline+=%{statusline#StatusLineBuffNum()}
set statusline+=%<
set statusline+=%{statusline#StatusLineFileName()}
set statusline+=%m
set statusline+=%{statusline#StatusLineFiletype()}

" right section
set statusline+=%=
" file format
set statusline+=\ %{statusline#StatusLineFormat()}

" line number
set statusline+=\ [%l/%L
" column number
set statusline+=:%c
" % of file
set statusline+=\ %p%%]
" }}}

" tabline {{{
set tabline=%!tabline#Tabline()
" }}}

"}}}

" plugin config {{{

" fzf {{{
set rtp+=~/bin/fzf

nnoremap <C-p> :Files<CR>
nnoremap \pr :History<CR>
nnoremap \pb :Buffers<CR>
nnoremap \pt :BTags<CR>
nnoremap \pT :Tags<CR>
nnoremap \pl :Lines<CR>
nnoremap \pm :Marks<CR>

"let g:fzf_history_dir = '~/.local/share/fzf-history'
let g:fzf_layout = { 'down': '~40%' }
let g:fzf_colors =
            \ { 'fg':      ['fg', 'Normal'],
            \ 'bg':      ['bg', 'Normal'],
            \ 'hl':      ['fg', 'Comment'],
            \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
            \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
            \ 'hl+':     ['fg', 'Statement'],
            \ 'info':    ['fg', 'PreProc'],
            \ 'border':  ['fg', 'Ignore'],
            \ 'prompt':  ['fg', 'Conditional'],
            \ 'pointer': ['fg', 'Exception'],
            \ 'marker':  ['fg', 'Keyword'],
            \ 'spinner': ['fg', 'Label'],
            \ 'header':  ['fg', 'Comment'] }
" }}}

" easy-align {{{
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap gl <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap gl <Plug>(EasyAlign)
" }}}

" tagbar {{{
let g:tagbar_autofocus = 1
let g:tagbar_autoclose = 1
let g:show_linenumbers = 1
nnoremap \t :echo tagbar#currenttag('[%s]', '')<CR>
nnoremap \\t :exec("TagbarOpen('j')")<cr>
" }}}

" sneak {{{
map f <Plug>Sneak_f
map F <Plug>Sneak_F
map t <Plug>Sneak_t
map T <Plug>Sneak_T
" }}}

" undotree {{{
let g:undotree_WindowLayout = 2
nnoremap _U :exec('UndotreeToggle <bar> UndotreeFocus')<CR>
nnoremap \u :exec('UndotreeFocus')<CR>

function! g:Undotree_CustomMap()
    nmap <buffer> K <plug>UndotreeNextState
    nmap <buffer> J <plug>UndotreePreviousState
    nmap <buffer> \u q
endfunction
" }}}

" fugitive {{{
nnoremap _G :Glcd<CR>
" }}}

" markdown {{{
let g:markdown_fenced_languages = ['python', 'perl', 'c', 'cpp', 'ruby', 'bash', 'sh', 'sql', 'html']
let g:markdown_folding = 1
" }}}

" }}}

" mappings {{{

nnoremap j gj
nnoremap k gk
nnoremap ^ g^
nnoremap $ g$
nnoremap gj j
nnoremap gk k
nnoremap g^ ^
nnoremap g$ $

" allow c-j/c-k for cycling through insert mode completions
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>

" easy switch to prev buffer
nnoremap <BS> <C-^>

" default Y mapping is just.. wrong
nnoremap Y y$

" don't clobber unnamed register when pasting over text
xnoremap <silent> p p:if v:register == '"'<Bar>let @@=@0<Bar>endif<cr>

" change word under cursor and set as last search pattern
nnoremap <silent> c<Tab> :let @/=expand('<cword>')<cr>cgn

" insert current line into command line
if !has('patch-8.0.1787')
    cnoremap <C-r><C-l> <C-r>=getline('.')<CR>
endif

" buffer/tab switching
nnoremap gb :bnext<CR>
nnoremap gB :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap [b :bprevious<CR>
nnoremap ]t :tabnext<CR>
nnoremap [t :tabprevious<CR>

" arglist / quickfix / location list shortcuts
nnoremap ]a :next<CR>
nnoremap [a :previous<CR>
nnoremap [A :first<CR>
nnoremap ]A :last<CR>
nnoremap ]q :cnext<CR>
nnoremap [q :cprevious<CR>
nnoremap [Q :cfirst<CR>
nnoremap ]Q :clast<CR>
nnoremap \q :cclose<CR>
nnoremap ]l :lnext<CR>
nnoremap [l :lprevious<CR>
nnoremap [L :lfirst<CR>
nnoremap ]L :llast<CR>
nnoremap \l :lclose<CR>
nnoremap \<BS> :cclose<Bar>lclose<CR>

" Leader,{ and Leader,} move to top and bottom of indent region
nmap \{ <Plug>(VerticalRegionUp)
nmap \} <Plug>(VerticalRegionDown)
omap \{ <Plug>(VerticalRegionUp)
omap \} <Plug>(VerticalRegionDown)
if exists(':xmap')
    xmap \{ <Plug>(VerticalRegionUp)
    xmap \} <Plug>(VerticalRegionDown)
endif

" adjust indent of last edit
nnoremap \< :<C-U>'[,']<<CR>
nnoremap \> :<C-U>'[,']><CR>

" buffers and ready to switch
" nnoremap \b :buffers<CR>:b<Space>
nnoremap \b :B<CR>

" fuzzy find in path
nnoremap \f :find **/*
nnoremap \F :find **/

" redraw screen
nnoremap \! :redraw!<CR>

" highlight interesting words
nnoremap _1 :call hiwords#HiInterestingWord(1)<cr>
nnoremap _2 :call hiwords#HiInterestingWord(2)<cr>
nnoremap _3 :call hiwords#HiInterestingWord(3)<cr>
nnoremap _4 :call hiwords#HiInterestingWord(4)<cr>
nnoremap _5 :call hiwords#HiInterestingWord(5)<cr>
nnoremap _6 :call hiwords#HiInterestingWord(6)<cr>

" trim trailing whitespace
command! StripTrailingWhitespace call whitespace#StripTrailingWhitespace()
command! -range=% StripTrailingWhitespaceVisual '<,'> call whitespace#StripTrailingWhitespaceVisual()
nnoremap \w :StripTrailingWhitespace<CR>
xnoremap \w :StripTrailingWhitespaceVisual<CR>

" toggle list
nnoremap _L :<C-U>setlocal list! list?<CR>
if exists(':xnoremap')
    xnoremap _L :<C-U>setlocal list! list?<CR>gv
endif

" line number management
command! ToggleLineNum call lnum#ToggleLineNum()
nnoremap _n :ToggleLineNum<cr>

" show declaration
" from https://gist.github.com/romainl/a11c6952f012f1dd32c26fad4fa82e43
nnoremap \d :call showdecl#ShowDeclaration(0)<CR>
nnoremap \D :call showdecl#ShowDeclaration(1)<CR>

" substitute operator
nmap <silent> \s  m':set operatorfunc=substitute#Substitute<CR>g@

" grepping {{{
" FGrep <pattern> -> quickfix
command! -nargs=1 FGrep cgetexpr system(&grepprg . ' ' . <q-args> . ' ' . expand('%')) | copen
nnoremap <Space> :FGrep<Space>

" Grep <pattern> -> quickfix
command! -nargs=1 Grep cgetexpr system(&grepprg . ' ' . <q-args>) | copen
nnoremap gsg :Grep<Space>

" view all todo in quickfix window
nnoremap <silent> \vt :exec('lvimgrep /todo/j %')<cr>:exec('lopen')<CR>
nnoremap <silent> \vT :exec('Rg todo')<CR>

" gitgrep for word under cursor in current file and open in location list
nnoremap <silent> gr :execute('FGrep ' . expand('<cword>'))<CR>

" gitgrep for word under cursor in current directory open in quickfix
nnoremap <silent> gR :exec('Grep ' . expand('<cword>'))<CR>
" }}}

" cdo/cfdo if not available
" from: https://www.reddit.com/r/vim/comments/iiatq6/is_there_a_good_way_to_do_vim_global_find_and/
if !exists(':cdo')
    command! -nargs=1 -complete=command Cdo try | sil cfirst |
                \ while 1 | exec <q-args> | sil cn | endwhile |
            \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
            \ endtry

    command! -nargs=1 -complete=command Cfdo try | sil cfirst |
                \ while 1 | exec <q-args> | sil cnf | endwhile |
            \ catch /^Vim\%((\a\+)\)\=:E\%(553\|42\):/ |
            \ endtry
endif

" better scrolling
nnoremap <expr> <C-b> max([winheight(0) - 2, 1]) . '<C-u>' . (line('.') < 1         + winheight(0) ? 'H' : 'L')
nnoremap <expr> <C-f> max([winheight(0) - 2, 1]) . '<C-d>' . (line('.') > line('$') - winheight(0) ? 'L' : 'H')

" redir
command! -nargs=1 -complete=command -bar -range Redir silent call redir#Redir(<q-args>, <range>, <line1>, <line2>)

" toggle paste mode and enter insert mode
nnoremap _p :set paste! paste?<CR>i
" just toggle paste..
nnoremap _P :set paste! paste?<CR>

" toggle spell checking
nnoremap _s :<C-u>setlocal spell! spell?<CR>

" echo filetype
nnoremap _t :<C-u>set filetype?<CR>

" reload filetype plugins
nnoremap _T :<C-u>doautocmd filetypedetect BufRead<CR>

" echo current file full path
nnoremap _f :echo expand('%:p')<cr>

" git and diff shortcuts
nnoremap _gg :echo system('git branch && git status')<CR>
nnoremap _gd :echo system('git diff ' . expand('%'))<CR>
nnoremap _gD :!clear && git diff %<CR>
nnoremap _gb :GitBranch<CR>
nnoremap _dh :Diff HEAD<CR>
nnoremap _dd :Diff<CR>
nnoremap _do :diffoff<CR>
nnoremap <expr> _<space> ":\<C-u>".(&diff ? 'diffoff' : 'diffthis') . "\<CR>"

" quick shell command
nnoremap _! :!<Space>

" show all registers
nnoremap \y :<C-u>registers<CR>
" show marks
nnoremap \k :<C-u>marks<CR>
" command history
nnoremap \H :<C-u>history :<CR>
nnoremap \h q:
" search history
nnoremap \/ q/

" toggle showing tab, end-of-line, and trailing whitespace
nnoremap _l :<C-u>setlocal list! list?<CR>
if exists(':xnoremap')
    xnoremap _l :<C-u>setlocal list! list?<CR>gv
endif

" normal maps
nnoremap _m :<C-u>map<CR>
" buffer-local normal maps
nnoremap _M :<C-u>map <buffer><CR>
" show global variables
nnoremap _v :<C-u>let g: v:<CR>
" show local variables
nnoremap _V :<C-u>let b: t: w:<CR>

" echo current highlight
nnoremap _h :echo synIDattr(synID(line('.'), col('.'), 1), 'name')<CR>

" toggle line and column markers
nnoremap <F3> :set cursorline! cursorcolumn!<CR>
nnoremap \c :set cursorline! cursorline?<cr>
nnoremap \C :set cursorcolumn! cursorcolumn?<cr>

" Switch CWD to the directory of the open buffer
nnoremap _Cd :cd %:p:h<cr>:pwd<cr>

" open scratch buffers
nnoremap \` :<C-U>Scratch<CR>

" search for non-ASCII characters
nnoremap \a /[^\x00-\x7F]<CR>

" poor man's c_CTRL-G/c_CTRL-T.. use c-j/c-k to move thru search res as typing
cnoremap <expr> <C-g> getcmdtype() =~ '[\/?]' ? '<CR>/<C-r>/' : '<C-g>'
cnoremap <expr> <C-t> getcmdtype() =~ '[\/?]' ? '<CR>?<C-r>/' : '<C-t>'

" list and be ready to jump to cword
nnoremap <F4> [I:let n = input('> ')<Bar>exe 'normal ' . n . '[\t'<CR>

" ilist
nnoremap \i :Ilist!<Space>
nnoremap \I :Ilist! <C-r>=expand('<cword>')<CR><CR>

" ijump
nnoremap gsj :ijump! <C-r>=expand('<cword>')<CR><CR>

" quick jump to tag under curosr
nnoremap gst :tjump /<C-r>=expand('<cword>')<CR><CR>

" g search
nnoremap \gw :g//#<Left><Left>
nnoremap \gW :g/<C-r>=expand('<cword>')<CR>/#<CR>

" quick search and replace
" https://github.com/romainl/minivimrc/blob/master/vimrc
nnoremap \rp :'{,'}s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap \ra :%s/\<<C-r>=expand('<cword>')<CR>\>//c<Left><Left>

" :help include-search shortcuts
nnoremap gsp :<C-u>psearch <C-r><C-w><CR>
nnoremap gsi [<C-i>
nnoremap gsd [<C-d>

" quick make to location list
nnoremap <F5> :lmake %<CR>

" Do and insert results of math equations via python
" from https://github.com/alerque/que-vim/blob/master/.config/nvim/init.vim
command! -nargs=+ Calc :r! python3 -c 'from math import *; print (<args>)'

" show list of digraphs -- special symbols
nnoremap \vd :help digraphs<cr>:179<cr>zt

" upper case last word using ctrl+u
inoremap <C-u> <Esc>gUiwea

" Shift-Tab enters actual tab
inoremap <S-Tab> <C-v><Tab>

" stay where you are on *
nnoremap <silent> * :let lloc = winsaveview()<cr>*:call winrestview(lloc)<cr>

" Disable highlight
nnoremap <C-l> :nohlsearch<cr>

" last changed text as an object
onoremap \_ :<C-U>execute 'normal! `[v`]'<CR>

if has('terminal') || has('nvim')
    " easy terminal exit
    tnoremap <esc> <C-\><C-n>
endif

nnoremap \ev :vsplit $MYVIMRC<cr>
nnoremap \es :source $MYVIMRC<cr> :echo 'sourced ' . $MYVIMRC<cr>
" }}}

" Source any .vim files from ~/.vim/config {{{
runtime! config/*.vim
" }}}
