if has('gui_running')
  colorscheme xoria256
endif

if has('unix')
  set guifont=Inconsolata\ 13
else
  " set guifont=Monospace_821_BT:h10
  " set guifont=Monaco:h11          " windows
  " source $VIMRUNTIME/vimrc_example.vim
  " source $VIMRUNTIME/mswin.vim
  " behave mswin
endif

set encoding=utf8
set guioptions-=T
set guioptions-=m

function! ToggleGuiOptions()
  if &guioptions =~# 'T'
    set guioptions-=T
    set guioptions-=m
  else
    set guioptions+=T
    set guioptions+=m
  endif
endfunction

function! ToggleNu()
  if &number == 0
    set number
  else
    set nonumber
  endif
endfunction

" nmap <silent> <F5> :call ToggleGuiOptions()<cr>
nmap <silent> <F5> :call ToggleNu()<cr>

set fileformat=unix

set nobackup
set nowritebackup
set noswapfile

" window size
set lines=34
set columns=148
se showtabline=2

set autoindent
set smartindent
set expandtab
set shiftwidth=2
set softtabstop=2
set tabstop=2
set smarttab
set autochdir
set hlsearch
set incsearch
set hidden
set diffopt=filler
set diffopt+=vertical
set diffopt+=iwhite
" set updatetime=1000

set iskeyword+=-

" braces autoclosing
imap [ []<LEFT>
imap ( ()<LEFT>
" imap { {}<LEFT>
inoremap { {}<LEFT>
inoremap {<cr> {<cr><bs>}<esc>O

inoremap " ""<LEFT>
inoremap ' ''<LEFT>
snoremap ' ''<LEFT>

"inoremap <C-space> <C-x><C-o>

nnoremap <silent> <c-s-pagedown> :execute 'silent! tabmove ' . tabpagenr()<CR>
nnoremap <silent> <c-s-pageup> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>

autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

function! BufNewFile_PY()
0put = '#!/usr/bin/env python'
1put = '#-*- coding: utf-8 -*-'
normal G
endfunction
autocmd BufNewFile *.py call BufNewFile_PY()

" au FileType javascript set syntax=jquery
au FileType htmldjango set ft=html.htmldjango

nmap <F2> :w<cr>
imap <F2> <esc>:w<cr>
nmap <F6> :bp<cr>
nmap <F7> :bn<cr>
nmap <F9> :NERDTreeToggle<cr>
" new
" nmap <F4> *:noautocmd vimgrep /<c-r>//j **/* <bar> :copen<cr>
" nmap <F4> g*:noautocmd Ggrep '\W<c-r>/\W' <bar> :copen<cr>
nmap <F4> :Ggrep '\W<c-r>=expand("<cword>")<cr>\W'<cr> <bar> :copen<cr>
nmap g<F4> :Ggrep -l '\W<c-r>=expand("<cword>")<cr>\W'<cr> <bar> :copen<cr>
nmap <F10> :NERDTreeFind<cr>
nmap <F12> :copen<cr>

call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

let g:user_zen_leader_key = '\'

" search file (working dir should be the root)
nnoremap <c-t> 1gt:<c-u>FufFile **/<cr>

" Window operations
  " Alt key is much handy
" map <M-h> <C-w>h
" map <M-j> <C-w>j
" map <M-k> <C-w>k
" map <M-l> <C-w>l
" map <M-c> <C-w>c
  " split
" map <M-s> :sp<CR>
" map <M-v> :vsplit<CR>
  " vertical resize by 2 lines
nmap <M-=> <C-W>2+
nmap <M--> <C-W>2-
  " horizontal resize by 2 digits
nmap <M-.> <C-w>2>
nmap <M-,> <C-w>2<
  " moving windows
" map <M-J> <C-w>J
" map <M-K> <C-w>K
" map <M-H> <C-w>H
" map <M-L> <C-w>L
  " Exchange current window with next one
" map <M-x> <C-w>x
  " Move the current window to a new tab page
" map <M-t> <C-w>T
nmap <m-t> :tabnew 
nmap <m-d> :diffsplit 
vmap <m-b> :Gblame<cr>

""""""""""
set showcmd
set linebreak
set matchpairs+=<:>
" set browsedir

set foldmethod=indent
set foldlevel=1
" toggle folds with space
nmap <space> za

function! ToggleFoldMethod()
  if &foldmethod == 'diff'
    " echo 'diff'
    set foldmethod=indent
  else
    " echo 'nodiff'
    set foldmethod=diff
  endif
endfunction
nmap <silent> <F3> :call ToggleFoldMethod()<cr>

imap <c-f> <right>
" set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
" set keymap=russian-jcukenwin
" set iminsert=0
set keymap=russian-jcukenwin
set iminsert=0
set imsearch=0
highlight lCursor guifg=NONE guibg=Cyan
au BufRead,BufNewFile * syntax match ErrorMsg /\t/
" au BufRead,BufNewFile * syntax match ErrorMsg /\s\+$/
au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%80v.\+', -1)

function! JsStyling()
  %s:\s\+$::ge
  %s:\t:  :ge
  %s:){:) {:e
  %s:if\s*(\s*:if ( :e
  %s:}\_\s*else\s*{:} else {:e
  g:\<if\>:s:\s*) {$: ) {:e
  %s:\(\S\)\s*\(&&\|||\)\s*:\1 \2 :ge
endfunction

function! HamlStyling()
  %s:{{\(\w\+\)}}:{{ \1 }}:ge
  %s:\([^{]\){\s*\([^{]\):\1{ \2:ge
  %s:\([^}]\)\s*}$:\1 }:ge
  %s:\(\S\)\s*=>\s*\(\S\):\1 => \2:ge
endfunction

function! MergeSnippets()
  " merge.sh
  " for file in `ls .`
  " do
  "   echo $file >> ruby.snippets
  "   cat $file >> ruby.snippets
  " done
  " for file in `ls .` do; echo $file >> ruby.snippets; cat $file >> ruby.snippets; done
  v:snippet:s:^:\t:
  g:snippet:s:^\(\w\+\).*$:snippet \1:
endfunction

set virtualedit=block

set listchars=trail:$
set list

" :redir @a>
" :history : -20,
" :redir END
" "ap
