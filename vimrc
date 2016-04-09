" .vimrc

" ========================== GENERAL SETTINGS =============================== "

" Use Vim settings, rather then Vi settings (much better!). 
" This must be first, because it changes other options as a side effect. 
set nocompatible 

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

" always set autoindenting on 
set autoindent

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

" Only do this part when compiled with support for autocommands. 
if has("autocmd") 

    " Enable file type detection. 
    " Use the default filetype settings, so that mail gets 'tw' set to 72, 
    " 'cindent' is on in C files, etc. 
    " Also load indent files, to automatically do language-dependent indenting. 
    filetype plugin indent on 

    " Line recommended by vim-pathogen
    execute pathogen#infect()
    
    " For all text files set 'textwidth' to 79 characters. 
    autocmd FileType text setlocal textwidth=79 

    function! ResCur()
	if line("'\"") <= line("$")
	    normal! g`"
	    return 1
	endif
    endfunction

    " Go to last position in file when it's opened (otherwise it starts you at
    " the top every time)
    autocmd BufWinEnter * call ResCur()

endif

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

" Set scripts to be executable from the shell
" au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x <afile> | endif
au BufWritePost * if getline(1) =~ "^#!" | silent !chmod +x <afile>

" ============ STUFF TO WORK WITH PLUGINS AND EXTERNAL PROGRAMS ============== "

" ------------------------------ CTAGS --------------------------------------- "

" tell vim where tags are stored
:set tags=./tags,./.tags;
" make \ CTRL-] open function definition in new tab
:nnoremap <silent><Leader><C-]> <C-w><C-]><C-w>T

" ----------------------------- NERDTREE ------------------------------------- "

" Open/Close Nerd Tree window with CTRL-\
noremap <C-\> :NERDTreeToggle<CR>

" Close Vim if Nerd Tree window is the last one standing
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Nerd Tree changes suggested in
" http://stackoverflow.com/questions/5817730/changing-root-in-nerdtree

" the working directory is always the one where the active buffer is located
set autochdir

" make sure the working directory is set correctly
let NERDTreeChDirMode=2

" \n opens nerdtree at current file's directory
nnoremap <leader>n :NERDTree .<CR>

" Remove weird underlining behavior that shows up in Nerd Trees and html files
:hi cursorLine cterm=NONE gui=NONE

" ---------------------------  AUTOCLOSE ------------------------------------ "

" Tell AutoClose to do the right thing when you hit enter between () [] or {}
let g:AutoCloseExpandEnterOn="([{"

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

" ========================== OTHER KEY MAPPINGS ============================= "

" Tell j and k to navigate displayed lines instead of actual lines so that long
" wrapped around lines are more navigable
nnoremap j gj
nnoremap k gk

" Escape insert mode by quickly hitting jk
inoremap jk <esc>

" Edit and source ~/.vimrc using ,ev and ,sv
nnoremap <leader>ev :split $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>

" =========== RANDOM THINGS THAT MIGHT COME IN HANDY ONE DAY ================ "

" This is an alternative that also works in block mode, but the deleted 
" text is lost and it only works for putting the current register. 
"vnoremap p "_dp

" Don't use Ex mode, use Q for formatting 
" map Q gq " I haven't used this

