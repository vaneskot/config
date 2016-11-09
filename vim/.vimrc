" Vim settings file. Vim version: 7.3
" Kotenkov Ivan

" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" ============ Vundle config ============
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'https://github.com/gmarik/vundle.git'

Bundle 'https://github.com/AndrewRadev/switch.vim.git'
Bundle 'https://github.com/Lokaltog/vim-easymotion.git'
Bundle 'https://github.com/SirVer/ultisnips.git'
Bundle 'https://github.com/bling/vim-airline.git'
Bundle 'https://github.com/chrisbra/NrrwRgn.git'
Bundle 'https://github.com/derekwyatt/vim-scala.git'
Bundle 'https://github.com/honza/vim-snippets.git'
Bundle 'https://github.com/kien/ctrlp.vim.git'
Bundle 'https://github.com/kien/rainbow_parentheses.vim.git'
Bundle 'https://github.com/mhinz/vim-startify.git'
Bundle 'https://github.com/scrooloose/nerdtree.git'
Bundle 'https://github.com/scrooloose/syntastic.git'
Bundle 'https://github.com/sjl/gundo.vim.git'
Bundle 'https://github.com/terryma/vim-expand-region'
Bundle 'https://github.com/tpope/vim-commentary.git'
Bundle 'https://github.com/tpope/vim-endwise.git'
Bundle 'https://github.com/tpope/vim-fugitive.git'
Bundle 'https://github.com/tpope/vim-repeat.git'
Bundle 'https://github.com/tpope/vim-sensible.git'
Bundle 'https://github.com/tpope/vim-surround.git'
Bundle 'https://github.com/vim-scripts/IndexedSearch.git'
Bundle 'https://github.com/vim-scripts/a.vim.git'

" vim-scripts repos
Bundle 'L9'
Bundle 'molokai'

filetype plugin indent on     " required!
" ============ End of Vundle config ============

" Ninja plugin from Chromium, allows single file compilation.
if filereadable(expand("~/projects/browser/src/tools/vim/ninja-build.vim"))
  source ~/projects/browser/src/tools/vim/ninja-build.vim
endif

" Allow backspacing over everything in insert mode
set backspace=indent,eol,start

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
set tabstop=2
set shiftwidth=2
set shiftround

" Highlight 81 column
if version >= 703
  set colorcolumn=81
end

set statusline=%<%f%h%m%r%=ft:%y\ l:%l\ c:%c%V\ %p%%
" Statusline always on
set laststatus=2

" Modified tabline from http://www.offensivethinking.org/data/dotfiles/vimrc
set showtabline=2
if exists("+showtabline")
  function! JoinTabline(aux_list, filename_list)
    let s = ''
    for i in range(len(a:aux_list))
      let s .= a:aux_list[i] . a:filename_list[i]
    endfor
    let s .= '%#TabLineFill#' " blank highlighting between the tabs and the righthand close 'X'
    return s
  endfunction

  function! MyTabLine()
    " List with auxilliary information: tab number, buffer number, modifiers.
    let aux_list = []
    " List with filenames.
    let filename_list = []
    " Separate lists are needed so that we can shorten filenames if there is not enough space in the tabline.

    let tabline_length = 0

    " Generate per-tab description lists
    for i in range(tabpagenr('$'))
      " set up some oft-used variables
      let tab = i + 1 " range() starts at 0
      let winnr = tabpagewinnr(tab) " gets current window of current tab
      let buflist = tabpagebuflist(tab) " list of buffers associated with the windows in the current tab
      let bufnr = buflist[winnr - 1] " current buffer number
      let bufname = fnamemodify(bufname(bufnr), ":t") " gets the name of the current buffer in the current window of the current tab

      let aux_str = '%' . tab . 'T' " start a tab
      let aux_str .= (tab == tabpagenr() ? '%#TabLineSel#' : '%#TabLine#') " if this tab is the current tab...set the right highlighting
      let empty_len = len(aux_str)
      let aux_str .= ' ' . tab " current tab number
      let n = tabpagewinnr(tab,'$') " get the number of windows in the current tab
      if n > 1
        let aux_str .= ':' . n " if there's more than one, add a colon and display the count
      endif
      let aux_str .= ' '
      let tabline_length += len(aux_str) - empty_len + 1

      call add(aux_list, aux_str)

      let filename_str = ''
      if bufname != ''
        let filename_str .= bufname . ' ' " outputs filename
      else
        let filename_str .= '[No Name] '
      endif
      let tabline_length += len(filename_str)
      call add(filename_list, filename_str)
    endfor

    " Shorten filenames if tabs don't fit.
    if tabline_length > &columns
      let n_files = len(filename_list)
      let residue = tabline_length - &columns
      let crop_len = float2nr(ceil(residue / (n_files - 1)))
      for i in range(len(filename_list))
        if i != tabpagenr() - 1
          let current_element_len = len(filename_list[i])
          let new_len = current_element_len - 1 > crop_len ? current_element_len - 1 - crop_len : 1
          let filename_list[i] = strpart(filename_list[i], 0, new_len) . ' '
        endif
      endfor
    endif

    return JoinTabline(aux_list, filename_list)
  endfunction
  set tabline=%!MyTabLine()
endif

" Set title of the window to filename [+=-] (path) - VIM
" Only available when compiled with the +title feature
set title

" Minimal number of lines to keep above and below the cursor
" Typewriter mode = keep current line in the center
set scrolloff=999

" Horizontal scroll off settings
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
    au! BufRead,BufNewFile *.gyp    setlocal filetype=python expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile *.gypi   setlocal filetype=python expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile DEPS     setlocal filetype=python expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile vundlerc setlocal filetype=vim expandtab tabstop=2 shiftwidth=2
    au! BufRead,BufNewFile .bash_aliases setlocal filetype=sh expandtab tabstop=2 shiftwidth=2
  augroup END

  " Compile/execute file on <leader>r
  augroup run_command
    au! BufRead,BufNewFile *.cpp,*.cc let b:run_command="!clang++ -g -std=c++11 % -o %<"
    au! BufRead,BufNewFile */browser*/*.cpp,*/browser*/*.cc,*/browser*/*.h let b:run_command=":CrCompileFile"
    au! BufRead,BufNewFile *.py let b:run_command="!python %"
    au! BufRead,BufNewFile *.sml let b:run_command="!sml %"
    au! BufRead,BufNewFile *.js let b:run_command="!/usr/local/bin/node %"
    au! BufRead,BufNewFile *.scala let b:run_command="!scala %"
    nmap <expr> <leader>r exists('b:run_command') ? ':execute b:run_command<CR>' : ''
  augroup END

  " Automatically add define guards to a header file
  augroup headers
    autocmd BufNewFile *.h call CppHeaderNewFile()
    autocmd BufNewFile *.hpp call CppHeaderNewFile()
    autocmd BufNewFile *.cpp call CppImplNewFile()
    autocmd BufNewFile *.cc call CppImplNewFile()
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

" Abbreviations
iab retrun return

" Maps

" Russian language support
if has("win32")
  set langmap=ÔÈÑÂÓÀÏÐØÎËÄÜÒÙÇÉÊÛÅÃÌÖ×Íß;ABCDEFGHIJKLMNOPQRSTUVWXYZ,ôèñâóàïðøîëäüòùçéêûåãìö÷íÿ;abcdefghijklmnopqrstuvwxyz
elseif has("mac")
  set langmap=ФИСВУАПРШОЛДЬТЩЗЙКЫЕГМЦЧНЯ;ABCDEFGHIJKLMNOPQRSTUVWXYZ,фисвуапршолдьтщзйкыегмцчня;abcdefghijklmnopqrstuvwxyz,ХЪ;{}
endif

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

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
noremap <expr> <leader>q tabpagenr('$') > 1 ? ':tabclose<CR>:tabprevious<CR>' : ':qa<CR>'

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

" Search matches are always in center
nmap n nzz
nmap N Nzz
nmap * *zz
nmap # #zz
nmap g* g*zz
nmap g# g#zz

" Select text that was just pasted
noremap gV `[v`]

" Forbid arrow movement
noremap <Up> <nop>
noremap <Down> <nop>
noremap <Left> <nop>
noremap <Right> <nop>
inoremap <Up> <nop>
inoremap <Down> <nop>
inoremap <Left> <nop>
inoremap <Right> <nop>

" Use arrow keys to resize windows
noremap <up>    <C-W>+
noremap <down>  <C-W>-
noremap <left>  3<C-W><
noremap <right> 3<C-W>>

" Remove that stupid window.
map q: :q

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

" Fast VundleInstall
map <leader>vb :source ~/.vimrc<CR>:BundleInstall<CR>

" Clear highlight
map <silent> <leader>c :nohlsearch<CR>

" Remove trailing spaces
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR><C-O>

" Exit insert mode with jj
map! jj <Esc>

" Paste like in paste mode without entering paste mode.
map <leader>p :r!cat<CR>

" Allow bash-like movement with CTRL-E and CTRL-A in command and insert modes.
cnoremap <c-e> <end>
imap     <c-e> <c-o>$
cnoremap <c-a> <home>
imap     <c-a> <c-o>^

" Git maps
map <leader>gC :!git checkout %<CR>
map <leader>ga :!git add %<CR>
map <leader>gp :!git add -p %<CR>
map <leader>gc :!git mdc %<CR>

" Ctags/cscope maps
map <leader>tt :tab tag
map <leader>th :tab tag <C-R><C-W>.h<CR>
map <leader>tj :tab tj <C-R><C-W><CR>
map <leader>cs :tab cs find s <C-R><C-W><CR>

" Sort selected lines
vmap <leader>s :sort<CR>

" clang-format selected lines or current line if none are selected.
if filereadable(expand("~/projects/config/vim/clang-format.py"))
  map <leader>cf :pyf ~/projects/config/vim/clang-format.py<CR>
endif

" Dont continue comments when pushing o/O
au FileType * setl formatoptions-=cro

" Plugin settings

" Use gcc, then cpplint as cpp checkers
let g:syntastic_cpp_checkers=['gcc', 'cpplint']
let g:syntastic_cpp_check_header = 1
let g:syntastic_cpp_compiler_options = '-std=c++11'

let g:alternateExtensions_h = "c,cpp,cxx,cc,CC,mm"
let g:alternateExtensions_mm = "h"

" NERDTree
nmap <leader>n :NERDTreeToggle %<CR>
let NERDTreeQuitOnOpen=1
let NERDTreeShowHidden=1
" Disable display of the 'Bookmarks' label and 'Press ? for help' text
let NERDTreeMinimalUI=1

" Ultisnips
let g:UltiSnipsEditSplit = 'context'

let g:rbpt_colorpairs = [
  \ ['Darkblue',    'SeaGreen3'],
  \ ['darkgray',    'DarkOrchid3'],
  \ ['darkgreen',   'firebrick3'],
  \ ['darkcyan',    'RoyalBlue3'],
  \ ['darkmagenta', 'DarkOrchid3'],
  \ ['darkred',     'DarkOrchid3'],
  \ ]

if has("autocmd")
  au VimEnter * RainbowParenthesesToggle
  au Syntax * RainbowParenthesesLoadBraces
  au Syntax * RainbowParenthesesLoadRound
  au Syntax * RainbowParenthesesLoadSquare

  autocmd FileType sml set commentstring=(*\ %s\ *)
  autocmd FileType cpp set commentstring=//\ %s
endif

let g:startify_bookmarks = ['~/.vimrc',]
let g:startify_change_to_dir = 0
if executable('fortune')
  let g:startify_custom_header = map(split(system('fortune ~/.vim/vimtips'), '\n'), '"   ". v:val') + ['','']
endif
highlight StartifyHeader ctermfg=114

let g:airline_enable_branch = 0
let g:airline_enable_syntastic = 1
let g:airline_mode_map = {
    \ '__' : '-',
    \ 'n'  : 'N',
    \ 'i'  : 'I',
    \ 'R'  : 'R',
    \ 'c'  : 'C',
    \ 'v'  : 'V',
    \ 'V'  : 'V',
    \ '' : 'V',
    \ 's'  : 'S',
    \ 'S'  : 'S',
    \ '' : 'S',
    \ }

" Plugin maps

" Switch between header and cpp file
map <leader>hh :A<CR>
map <leader>hv <C-w><C-v><leader>hh

map <leader>u :GundoToggle<CR>

nmap <leader>s :tabe %<CR>:Gstatus<CR>
nmap <leader>b :.Gblame<CR>
vmap <leader>b :Gblame<CR>
map <leader>B :Gblame<CR>

nmap <leader>pr :call OpenBlamePullRequest()<CR>

map - :Switch<CR>

" Merge helper - open merge conflict in separate window.
" Conflict should be in format <<< ||| === >>> and cursor should stand before
" <<< for the map to work properly.
map <leader>M  /<<<<<<<<CR>j V/\|\|\|\|\|\|\|<CR>k :NR<CR> <C-W>w njV/=======<CR>k :NR<CR> <C-W>w<C-W>H <C-W>W njV/>>>>>>><CR>k :NR<CR> <C-W>W <C-W>T :tabprevious<CR> <C-W>k<C-W>J <C-W>w :diffthis<CR> <C-W>w :diffthis<CR>

" Functions

function! GetUserName()
  let s:default_user_name = "Ivan Kotenkov"
  return executable('git') ? system('git config --get user.name')[:-2] : s:default_user_name
endfunction

function! GetUserEmail()
  let s:default_user_email = "ivan.kotenkov@gmail.com"
  return executable('git') ? system('git config --get user.email')[:-2] : s:default_user_email
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

function! OpenBlamePullRequest()
  let s:line = line(".")
  exe "!git blame -s -L" . s:line . "," . s:line . " -- " . expand("%"). " | awk '{print $1}' | xargs show-pull-request"
endfunction
