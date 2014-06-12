" Vim settings file. Vim version: 7.3
" Kotenkov Ivan

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Vundle config
source ~/.vim/bundle/vundlerc

" Use gcc, then cpplint as cpp checkers
" TODO: check whether the plugin is loaded
let g:syntastic_cpp_checkers=['gcc', 'cpplint']

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif

set undofile
set undodir=~/.vim/undodir

" Allow system clipboard on macos
if has("mac") || has("macunix")
  if has("clipboard")
    set clipboard=unnamed
  endif
endif

" Keep 500 lines of command line history
set history=500
" Show the cursor position all the time
set ruler
" Display incomplete commands
set showcmd
set incsearch
set gdefault
set ignorecase
" Ignore register when all letters are lowercase
set smartcase

" Set tab to 2 spaces
set expandtab
set ts=2
set sw=2

" Highlight 81 column
set colorcolumn=81

set statusline=%<%f%h%m%r%=ft:%y\ l:%l\ c:%c%V\ %p%%
" Statusline always on
set laststatus=2

" Vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Show numbers of lines to the left
set number
" Show relative numbers of lines
set relativenumber
" Higlight current line
set cursorline

" Allow the cursor to go in to "invalid" places
set virtualedit=all

" Make cmdline tab completion similar to bash
set wildmode=list:longest
" Enable ctrl-n and ctrl-p to scroll thru matches
set wildmenu
" Stuff to ignore when tab completing
set wildignore=*.o,*.obj,*~

" Don't break the line, we have to goooo. cause there's no way back where we're coming from
set nowrap

" Folding
set foldmethod=indent
set nofoldenable

" Forbid scanning through boost files for autocompletion
set include=^\\s*#\\s*include\ \\(<boost/\\)\\@!

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" We don't need no fckin mouse
set mouse=

" Search for tags file from the current directory up to $HOME directory
set tags+=./tags;$HOME

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set background=dark

  syntax on

  " from http://vim.wikia.com/wiki/Highlight_unwanted_spaces
  highlight ExtraWhitespace ctermbg=lightgray guibg=lightgray
  autocmd ColorScheme * highlight ExtraWhitespace ctermbg=lightgray guibg=lightgray
  match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/

  colorscheme molokai

  " Highlight cursorline with light gray bgcolor
  highlight CursorLine ctermbg=237

  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
    au!

    " For all text files set 'textwidth' to 80 characters.
    autocmd FileType text setlocal textwidth=80

    " When editing a file, always jump to the last known cursor position.
    " Don't do it when the position is invalid or when inside an event handler
    " (happens when dropping a file on gvim).
    " Also don't do it when the mark is in the first line, that is the default
    " position when opening a file.
    autocmd BufReadPost *
      \ if line("'\"") > 1 && line("'\"") <= line("$") |
      \   exe "normal! g`\"" |
      \ endif

  augroup END

  augroup filetype
    au! BufRead,BufNewFile *.gyp    set filetype=python expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile *.gypi   set filetype=python expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile DEPS     set filetype=python expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile vundlerc set filetype=vim expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile .bash_aliases set filetype=sh expandtab tabstop=2 shiftwidth=2
  augroup END
else
  " always set autoindenting on
  set autoindent
endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Encodings
set fileencodings=utf-8,cp1251

" Maps

" Russian language support
if has("win32")
  set langmap=ÔÈÑÂÓÀÏÐØÎËÄÜÒÙÇÉÊÛÅÃÌÖ×Íß;ABCDEFGHIJKLMNOPQRSTUVWXYZ,ôèñâóàïðøîëäüòùçéêûåãìö÷íÿ;abcdefghijklmnopqrstuvwxyz
elif has("unix")
  set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz
else
  " Russian support for mac os
  set keymap=russian-jcuken
  set iminsert=0
  set imsearch=0
endif

" Visual shifting
vnoremap < <gv
vnoremap > >gv

" Folding
imap <F3> <ESC>zAi
nmap <F3> zA
imap <F4> <ESC>:set foldmethod=indent<CR>:set foldenable!<CR>i
nmap <F4> :set foldmethod=indent<CR>:set foldenable!<CR>

" Comments in c
nmap <F5> o/*****************************************************<ESC>:left<CR>
nmap <F6> o*****************************************************/<ESC>:left<CR>

" Save
imap <F8> <ESC>:w<CR>
nmap <F8> :w<CR>

" Exit
map <F9>  <ESC>:q<CR>
map <F10> <ESC>:wq<CR>
map <F11> <ESC>:wqa<CR>
map <leader>q :tabclose<CR>:tabprevious<CR>

nnoremap <silent> <PageUp> <C-U><C-U>
vnoremap <silent> <PageUp> <C-U><C-U>
inoremap <silent> <PageUp> <C-\><C-O><C-U><C-\><C-O><C-U>

nnoremap <silent> <PageDown> <C-D><C-D>
vnoremap <silent> <PageDown> <C-D><C-D>
inoremap <silent> <PageDown> <C-\><C-O><C-D><C-\><C-O><C-D>

" Easy tab movement
nmap <C-h> :tabprevious<CR>
nmap <C-l> :tabnext<CR>

" End of the line - start of the line
nmap H ^
nmap L $

" Forbid arrow movement
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Jump to tag in a new tab
map <C-W>} :tab split<CR>:exec("tag ".expand("<cword>"))<CR>

" Jump to tag in a vertical split
map <C-W><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" Useful newline bindings for normal mode
map <BS> O<Esc>
map <CR> o<Esc>

" Paste path to current file in command mode
cmap <leader>e <C-r>=expand("%:h")<CR>/

" Fast .vimrc access
map <leader>vt :tabe ~/.vimrc<CR>
map <leader>vs :source ~/.vimrc<CR>

" Clear highlight
map <silent> <leader>c :nohlsearch<CR>

" Remove trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR><C-O>

" Exit insert mode with jj
map! jj <Esc>

" Run python file
map <leader>p :!python %<CR>

" Plugin maps

" Switch between header and cpp file
map <leader>hh :A<CR>
map <leader>hv <C-w><C-v><leader>hh

map <leader>u :GundoToggle<CR>

map <leader>s :tabe %<CR>:Gstatus<CR>
nmap <leader>b :.Gblame<CR>
vmap <leader>b :Gblame<CR>
map <leader>B :Gblame<CR>

map <leader>tt :tab tag
map <leader>th :tab tag <C-R><C-W>.h<CR>
map <leader>tj :tab tj <C-R><C-W><CR>

map <leader>cs :tab cs find s <C-R><C-W><CR>

" Automatically add define guards to a header file
autocmd BufNewFile *.h call CppHeaderNewFile()
autocmd BufNewFile *.hpp call CppHeaderNewFile()
autocmd BufNewFile *.cpp call CppImplNewFile()
autocmd BufNewFile *.cc call CppImplNewFile()

" Dont continue comments when pushing o/O
au FileType * setl formatoptions-=cro

" Functions

function! BashHasCommand(command)
  return stridx(system('command -v ' . a:command), a:command) != -1
endfunction

function! GetUserName()
  let s:default_user_name = "Ivan Kotenkov"
  return BashHasCommand('git') ? system('git config --get user.name')[:-2] : s:default_user_name
endfunction

function! GetUserEmail()
  let s:default_user_email = "ivan.kotenkov@gmail.com"
  return BashHasCommand('git') ? system('git config --get user.email')[:-2] : s:default_user_email
endfunction

function! CppAuthor()
  let s:copyright = "// Copyright (c) " . strftime("%Y") . " Yandex LLC. All rights reserved."
  let s:author = "// Author: " . GetUserName() . " <" . GetUserEmail() . ">"
  let s:result_list = [s:author]
  if (match(s:author, "yandex-team") != -1)
    call insert(s:result_list, s:copyright)
  endif
  return s:result_list
endfunction

function! CppHeaderNewFile()
  let s:name = substitute(expand("%:t"), "[.]", "_", "")
  let s:new_name = substitute(s:name, ".*", "\\U\\0", "") . "_"
  let s:str_list = CppAuthor() + ["", "#ifndef " . s:new_name, "#define " . s:new_name, "", "", "", "#endif  // " .  s:new_name]
  call setline(line("."), s:str_list)
  7
endfunction

function! CppImplNewFile()
  call setline(line("."), CppAuthor() + ["", ""])
  4
endfunction
