" .vimrc

" ========================== GENERAL SETTINGS =============================== "

" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Use space instead of \ for leader key
let mapleader = " "

" This line helps avoid long vim startup times related to setting up the
" clipboard. You can look at startup times using `vim --startuptime out.log`
set clipboard=exclude:.*

" Make mouse usable for everything
" To copy a selection to system clipboard with this setting on, hold <fn>
" while selecting in Terminal.app or <option> in iTerm2.app
set mouse=a

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" inserts spaces for tabs
set expandtab

" number of spaces for each tab
set softtabstop=4

" number of spaces inserted on 'enter'
set shiftwidth=4

" 2 spaces per tab for specified files
autocmd FileType cpp setlocal shiftwidth=2 softtabstop=2
autocmd FileType c setlocal shiftwidth=2 softtabstop=2
autocmd FileType sh setlocal shiftwidth=2 softtabstop=2
autocmd FileType html setlocal shiftwidth=2 softtabstop=2
autocmd FileType shtml setlocal shiftwidth=2 softtabstop=2
autocmd FileType php setlocal shiftwidth=2 softtabstop=2
autocmd FileType tex setlocal shiftwidth=2 softtabstop=2
autocmd FileType vim setlocal shiftwidth=2 softtabstop=2

" always set autoindenting on
set autoindent

" indent continued line to align with parentheses.
" tip from http://stackoverflow.com/a/11986057/2680824
set cinoptions+=(0

" indent public and private keywords by 1 space in c++ classes
" variation of tip from http://stackoverflow.com/a/12353180/2680824
set cinoptions+=g1,h1

" do not keep a backup file, use versions instead
set nobackup

" keep 50 lines of command line history
set history=50

" show the cursor position all the time
set ruler

" display incomplete commands
set showcmd

" do incremental searching
set incsearch

" Show current line number and relative line numbers above and below
set number         " shortcut is set nu
set relativenumber " shortcut is set rnu

" Smarter scrolling
set scrolloff=15

" Make vertical and horizontal splits open to the right and below, respectively
set splitright
set splitbelow

" Folding
set foldmethod=indent
set foldlevelstart=20

" Turn on spell checking and give path to file of words to add to dictionary
autocmd FileType tex,plaintex set spell spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add

" For all text files and tex files, set 'textwidth' to 79 characters.
" This enforces 79 character width, or really 80 including newline character
autocmd FileType text,tex setlocal textwidth=79

function! ResCur()
    if line("'\"") <= line("$")
        normal! g`"
        return 1
    endif
endfunction

" Go to last position in file when it's opened (otherwise it starts you at
" the top every time)
autocmd BufWinEnter * call ResCur()

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
 syntax on
 set hlsearch
endif

" Set default color scheme
colorscheme desert

" Custom color scheme for vimdiff
if &diff
    colorscheme vimdiffcolors
endif

" Set coloring of line numbers on left
highlight LineNr ctermfg=black  ctermbg=lightgrey
highlight CursorLineNr ctermfg=lightgrey  ctermbg=black

" Set search hits highlight coloring
highlight Search ctermfg=white

" Highlight column 80 to help me keep files a standard width
set colorcolumn=80
highlight ColorColumn ctermbg=lightgrey

" Bold matching parenthesis or brace or bracket
highlight MatchParen ctermbg=white ctermfg=green

"Automatic headers
autocmd BufNewFile *.sh 0read ~/.vim/templates/skeleton.sh
autocmd BufNewFile *.py 0read ~/.vim/templates/skeleton.py

" Highlight Trailing whitespace
" see http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Set scripts to be executable from the shell
" au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x <afile> | endif
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x <afile>

" ============ STUFF TO WORK WITH PLUGINS AND EXTERNAL PROGRAMS ============= "

" ----------------------------- VIM-PLUG ------------------------------------ "

" Load vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
Plug 'LaTeX-Box-Team/LaTeX-Box'         " LaTeX stuff
Plug 'tmhedberg/matchit'                " Improved matching for % key
Plug 'scrooloose/nerdtree'              " Improved file navigation
Plug 'Townk/vim-autoclose'              " Automatically close pairs
Plug 'alvan/vim-closetag'               " Like Autoclose for html tags
Plug 'tpope/vim-fugitive'               " Use Git from within Vim
Plug 'terryma/vim-multiple-cursors'     " Select and edit multiple words
Plug 'tpope/vim-surround'               " Surround region with character pair
Plug 'tpope/vim-commentary'             " Comment lines using gc<object>
Plug 'ConradIrwin/vim-bracketed-paste'  " Seamless pasting from clipboard
Plug 'MarcWeber/vim-addon-mw-utils'     " Required for snipmate
Plug 'tomtom/tlib_vim'                  " Required for snipmate
Plug 'garbas/vim-snipmate'              " Framwork for inserting snippets
Plug 'honza/vim-snippets'               " Predefined snippets for snipmate
call plug#end()

" ------------------------------ CTAGS -------------------------------------- "

" tell vim where tags are stored
set tags=./tags,./.tags;
" <leader><CTRL-]> to open function definition in vertical split
nnoremap <silent><leader><c-]> <c-w>v<c-]>
" <leader>s<CTRL-]> to open function definition in horizontal split
nnoremap <silent><leader>s<c-]> <c-w>S<c-]>
" <leader>t<CTRL-]> to open function definition in new tab
nnoremap <silent><leader>t<c-]> <c-w><c-]><c-w>T

" ----------------------------- NERDTREE ------------------------------------ "

" Open/Close Nerd Tree window with CTRL-\
noremap <C-\> :NERDTreeToggle<CR>

" Close Vim if Nerd Tree window is the last one standing
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") &&
            \ b:NERDTree.isTabTree()) | q | endif

" Nerd Tree changes suggested in
" http://stackoverflow.com/questions/5817730/changing-root-in-nerdtree

" the working directory is always the one where the active buffer is located
set autochdir

" make sure the working directory is set correctly
let NERDTreeChDirMode=2

" Remove weird underlining behavior that shows up in Nerd Trees and html files
:hi cursorLine cterm=NONE gui=NONE

" ---------------------------- AUTOCLOSE ------------------------------------ "

" Tell AutoClose to do the right thing when you hit enter between () [] or {}
let g:AutoCloseExpandEnterOn="([{"

" --------------------------- COMMENTARY ------------------------------------ "

" Set commentstring for files so vim-commentary comments things correctly
autocmd FileType c,cpp setlocal commentstring=//\ %s

" --------------------------- LATEX-BOX ------------------------------------- "

" Turn on folding by sections
let g:LatexBox_Folding=1
" Open quickfix window on warning or error, but leave cursor in current window
let g:LatexBox_quickfix=2
" Automatically jump to first error after running latexmk
let g:LatexBox_autojump=1
" Table of contents width
let g:LatexBox_split_width=50

" --------------------------- AUTOCLOSE ------------------------------------- "

" Tell Autoclose to autoclose $$ pairs in tex files in addition to defaults
autocmd FileType tex let g:AutoClosePairs = "` \" [] \' () {} $"

" ================= CUSTOM LINE NUMBER TOGGLING BEHAVIOR ==================== "

function! NumberToggle()
    if(&relativenumber == 1)
        " If we have relative numbers, turn off numbers
        set nonumber
        set norelativenumber
    elseif(&number == 0)
        " If we have no numbers, turn on absolute numbers
        set number
        set norelativenumber
    else
        " If we have absolute numbers on and relative numbers off,
        " turn on relative numbers
        set number
        set relativenumber
    endif
endfunc

"Use \n to toggle between relative #'s -> no #'s -> absolute #'s -> rel...
nnoremap <silent><leader>n :call NumberToggle()<cr>

" ======================== AUTOMATIC C++ FORMATTING ========================= "

" Automatic header guards on new .h or .hpp file creation
" Adapted from:
" http://vim.wikia.com/wiki/Automatic_insertion_of_C/C%2B%2B_header_gates
function! s:insert_gates()
  let gatename = substitute(toupper(expand("%:t")), "\\.", "_", "g")
  execute "normal! i#ifndef " . gatename
  execute "normal! o#define " . gatename
  execute "normal! Go\n\n\n#endif // " . gatename
  normal! Gkk
endfunction
autocmd BufNewFile *.{h,hpp} call <SID>insert_gates()

" ========================== OTHER KEY MAPPINGS ============================= "

" Tell j and k to navigate displayed lines instead of actual lines so that long
" wrapped around lines are more navigable
nnoremap j gj
nnoremap k gk

" Escape insert mode by quickly hitting jk
inoremap jk <esc>

" Map H and L to  be strong left and right keys. i.e. H will go first to first
" non-whitespace character of line, or to beginning of line if already there
" H will toggle between 0 column and indent('.')+1 column. L will do a similar
" thing with the end of the line. Use > and < instead of == and flip the
" commands if you want it to be more of a 'hard' left and right
nnoremap <silent><expr> H col('.') == indent('.')+1 ? '0' : '^'
nnoremap <silent><expr> L col('.') == match(getline('.'), '\S\zs\s*$') ? '$' : 'g_'

" Operator mappings to allow stuff like cin( and cil( to replace text in next
" and last parentheses pairs. Replace ( with [ or { to do the same thing for
" bracket or brace pairs
:onoremap in( :<c-u>normal! f(vi(<cr>
:onoremap in) :<c-u>normal! f(vi)<cr>
:onoremap il( :<c-u>normal! F)vi(<cr>
:onoremap il) :<c-u>normal! F)vi)<cr>
:onoremap in[ :<c-u>normal! f[vi[<cr>
:onoremap in] :<c-u>normal! f[vi]<cr>
:onoremap il[ :<c-u>normal! F]vi[<cr>
:onoremap il] :<c-u>normal! F]vi]<cr>
:onoremap in{ :<c-u>normal! f{vi{<cr>
:onoremap in} :<c-u>normal! f{vi}<cr>
:onoremap il{ :<c-u>normal! F}vi{<cr>
:onoremap il} :<c-u>normal! F}vi}<cr>
:onoremap in" :<c-u>normal! f"vi"<cr>
:onoremap il" :<c-u>normal! F"vi"<cr>
:onoremap in' :<c-u>normal! f'vi'<cr>
:onoremap il' :<c-u>normal! F'vi'<cr>
:onoremap an( :<c-u>normal! f(va(<cr>
:onoremap an) :<c-u>normal! f(va)<cr>
:onoremap al( :<c-u>normal! F)va(<cr>
:onoremap al) :<c-u>normal! F)va)<cr>
:onoremap an[ :<c-u>normal! f[va[<cr>
:onoremap an] :<c-u>normal! f[va]<cr>
:onoremap al[ :<c-u>normal! F]va[<cr>
:onoremap al] :<c-u>normal! F]va]<cr>
:onoremap an{ :<c-u>normal! f{va{<cr>
:onoremap an} :<c-u>normal! f{va}<cr>
:onoremap al{ :<c-u>normal! F}va{<cr>
:onoremap al} :<c-u>normal! F}va}<cr>
:onoremap an" :<c-u>normal! f"va"<cr>
:onoremap al" :<c-u>normal! F"va"<cr>
:onoremap an' :<c-u>normal! f'va'<cr>
:onoremap al' :<c-u>normal! F'va'<cr>

" Move current line up or down with one keypress
nnoremap - ddkP
nnoremap _ ddp

" Open multiple lines (insert empty lines) before or after current line,
" and position cursor in the farthest line opened.
" Adapted from http://vim.wikia.com/wiki/Insert_multiple_lines
function! OpenLines(nrlines, dir)
  let nrlines = a:nrlines < 2 ? 2 : a:nrlines
  let start = line('.') + a:dir
  call append(start, repeat([''], nrlines))
  if a:dir < 0
    execute "normal! " . nrlines . "k"
  else
    execute "normal! " . nrlines . "j"
  endif
endfunction
" Mappings to open multiple lines and enter insert mode.
nnoremap <Leader>o :<C-u>call OpenLines(v:count, 0)<CR>S
nnoremap <Leader>O :<C-u>call OpenLines(v:count, -1)<CR>S

" Use CTRL-D to delete text just inserted in insert mode. This is mostly so if
" I create a new line after a comment that is automatically and unwantedly
" commented out, I can just type CTRL-D quick to clear the comment
inoremap <c-d> !<c-u>

" Use CTRL-u to uppercase current word (uses up marker z)
inoremap <c-u> <esc>mzviwU`za

" Remove all trailing whitespace in file with <leader>d
nnoremap <silent> <leader>d :let _s=@/<Bar>:%s/\s\+$//e<Bar>:let @/=_s<Bar>:nohl<CR>

" ':vh' expands to ':vert help' to open help window in vertical split
cnoremap vh vert help

" Shortcuts to edit and source ~/.vimrc.
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>Ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" Shortcut to run make
nnoremap <leader>m :!make<cr>

" Shortcut to run ctags
nnoremap <leader>c :!ctags -R -f .tags .<cr>

" =========== RANDOM THINGS THAT MIGHT COME IN HANDY ONE DAY ================ "

" This is an alternative that also works in block mode, but the deleted
" text is lost and it only works for putting the current register.
"vnoremap p "_dp

" Don't use Ex mode, use Q for formatting
" map Q gq " I haven't used this
