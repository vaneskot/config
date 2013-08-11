" Vim settings file. Vim version: 7.3
" Kotenkov Ivan

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

source ~/.vim/bundle/vundlerc

let g:syntastic_cpp_checkers=['gcc', 'cpplint']

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif

" Allow system clipboard on macos
if has("mac") || has("macunix")
  if has("clipboard")
    set clipboard=unnamed
  endif
endif

set history=500		" keep 500 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
set ignorecase " ignore case
set smartcase " ignore register when all letters are lowercase

" Set tab to 2 spaces
set expandtab
set ts=2
set sw=2

" Highlight 81 column
:set colorcolumn=81

set statusline=%<%f%h%m%r%=ft:%y\ l:%l\ c:%c%V\ %p%%
set laststatus=2 " statusline always on

" Vertical/horizontal scroll off settings
set scrolloff=3
set sidescrolloff=7
set sidescroll=1

" Show numbers of lines to the left
set number

set wildmode=list:longest "make cmdline tab completion similar to bash
set wildmenu "enable ctrl-n and ctrl-p to scroll thru matches
set wildignore=*.o,*.obj,*~ "stuff to ignore when tab completing

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

" In many terminal emulators the mouse works just fine, thus enable it.
"if has('mouse')
"  set mouse=a
"endif

" We don't need no fckin mouse
set mouse=

set tags+=./tags;$HOME

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  set background=dark
  syntax on
  colorscheme molokai
"  if !has("linux")
"    colorscheme desert
"  else
"    colorscheme default
"  endif
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
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

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

set formatoptions-=o "dont continue comments when pushing o/O

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
  " Russian support 
  set keymap=russian-jcuken 
  set iminsert=0 
  set imsearch=0
endif

"visual shifting
:vnoremap < <gv
:vnoremap > >gv

"folding
:imap <F3> <ESC>zAi
:nmap <F3> zA
:imap <F4> <ESC>:set foldmethod=indent<CR>:set foldenable!<CR>i
:nmap <F4> :set foldmethod=indent<CR>:set foldenable!<CR>

" Comments in c
:nmap <F5> o/*****************************************************<ESC>:left<CR>
:nmap <F6> o*****************************************************/<ESC>:left<CR>

"save
:imap <F8> <ESC>:w<CR>
:nmap <F8> :w<CR>

"exit
:map <F9>  <ESC>:q<CR>
:map <F10> <ESC>:wq<CR>
:map <F11> <ESC>:wqa<CR>

"change highlight search
:imap <F12> <ESC>:set hlsearch!<CR>i
:nmap <F12> :set hlsearch!<CR>

" Remove trailing spaces
:nmap <S-F12> :%s/ *$//<CR><C-O>

nnoremap <silent> <PageUp> <C-U><C-U>
vnoremap <silent> <PageUp> <C-U><C-U>
inoremap <silent> <PageUp> <C-\><C-O><C-U><C-\><C-O><C-U>

nnoremap <silent> <PageDown> <C-D><C-D>
vnoremap <silent> <PageDown> <C-D><C-D>
inoremap <silent> <PageDown> <C-\><C-O><C-D><C-\><C-O><C-D>

:nmap <C-h> :tabprevious<CR>
:nmap <C-l> :tabnext<CR>

" Forbid arrow movement
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Switch between header and cpp file
map <C-W>g :A<CR>

map <C-W>} :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <C-W><C-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

autocmd BufNewFile *.h call CHeader()

" Functions

function! CHeader()
  let name = substitute(expand("%:t"), "[.]", "_", "")
  let new_name = substitute(name, ".*", "\\U\\0", "")
  let str_list = ["#ifndef " . new_name, "#define " . new_name, "", "", "", "#endif // " .  new_name]
  call setline (line("."), str_list)
  4
endfunction
