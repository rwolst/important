" URL: http://vim.wikia.com/wiki/Example_vimrc
" Authors: http://vim.wikia.com/wiki/Vim_on_Freenode
" Description: A minimal, but feature rich, example .vimrc. If you are a
"              newbie, basing your first .vimrc on this file is a good choice.
"              If you're a more advanced user, building your own .vimrc based
"              on this file is still a good idea.

"------------------------------------------------------------
" Vundle package manager
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'w0rp/ale'
Plugin 'SirVer/ultisnips'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-vinegar'
Plugin 'jamessan/vim-gnupg'
Plugin 'FooSoft/vim-argwrap'
Plugin 'alvan/vim-closetag'
Plugin 'tpope/vim-abolish'

" All of your Plugins must be added before the following line
call vundle#end()            " required

"------------------------------------------------------------
" Features {{{1
"
" These options and commands enable some very useful features in Vim, that
" no user should have to live without.
 
" Set 'nocompatible' to ward off unexpected things that your distro might
" have made, as well as sanely reset options when re-sourcing .vimrc
set nocompatible
 
" Attempt to determine the type of a file based on its name and possibly its
" contents. Use this to allow intelligent auto-indenting for each filetype,
" and for plugins that are filetype specific.
filetype indent plugin on
 
" Enable syntax highlighting
syntax on
 
"------------------------------------------------------------
" Colorcheme
if ! has("gui_running")
    set t_Co=256
endif
" feel free to choose :set background=light for a different style
set background=dark
colors peaksea
 
"------------------------------------------------------------
" Must have options {{{1
"
" These are highly recommended options.
 
" Vim with default settings does not allow easy switching between multiple files
" in the same editor window. Users can use multiple split windows or multiple
" tab pages to edit multiple files, but it is still best to enable an option to
" allow easier switching between files.
"
" One such option is the 'hidden' option, which allows you to re-use the same
" window and switch from an unsaved buffer without saving it first. Also allows
" you to keep an undo history for multiple files when re-using the same window
" in this way. Note that using persistent undo also lets you undo in multiple
" files even in the same window, but is less efficient and is actually designed
" for keeping undo history after closing Vim entirely. Vim will complain if you
" try to quit without saving, and swap files will keep you safe if your computer
" crashes.
set hidden
 
" Note that not everyone likes working this way (with the hidden option).
" Alternatives include using tabs or split windows instead of re-using the same
" window as mentioned above, and/or either of the following options:
" set confirm
" set autowriteall
 
" Better command-line completion
set wildmenu
 
" Show partial commands in the last line of the screen
set showcmd
 
" Highlight searches (use <C-L> to temporarily turn off highlighting; see the
" mapping of <C-L> below)
set hlsearch
 
" Modelines have historically been a source of security vulnerabilities. As
" such, it may be a good idea to disable them and use the securemodelines
" script, <http://www.vim.org/scripts/script.php?script_id=1876>.
" set nomodeline
 
 
"------------------------------------------------------------
" Usability options {{{1
"
" These are options that users frequently set in their .vimrc. Some of them
" change Vim's behaviour in ways which deviate from the true Vi way, but
" which are considered to add usability. Which, if any, of these options to
" use is very much a personal preference, but they are harmless.

" Change the mapleader from \ to ,
let mapleader="," 

" Use case insensitive search, except when using capital letters
set ignorecase
set smartcase
 
" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start
 
" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent
 
" Stop certain movements from always going to the first character of a line.
" While this behaviour deviates from that of Vi, it does what most users
" coming from other editors would expect.
set nostartofline
 
" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler
 
" Always display the status line, even if only one window is displayed
set laststatus=2
 
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm
 
" Use visual bell instead of beeping when doing something wrong
set visualbell
 
" And reset the terminal code for the visual bell. If visualbell is set, and
" this line is also included, vim will neither flash nor beep. If visualbell
" is unset, this does nothing.
set t_vb=
 
" Enable use of the mouse for all modes
set mouse=a
 
" Set the command window height to 2 lines, to avoid many cases of having to
" "press <Enter> to continue"
set cmdheight=2
 
" Display line numbers on the left
set number

" Use hybrid numbering on in focus window, otherwise use absolute.
augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu | set rnu | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &nu | set nornu | endif
augroup END
 
" Quickly time out on keycodes, but never time out on mappings
set notimeout ttimeout ttimeoutlen=200
 
" Use <F11> to toggle between 'paste' and 'nopaste'
set pastetoggle=<F2>
 
" Underline cursor
set cursorline

" Don't wrap lines
set nowrap

" Show matching parantheses
set showmatch

" Show whitespace while editing
set list
set listchars=tab:>.,trail:.,extends:#,nbsp:.

" Display line telling you when you are over 80 characters
set colorcolumn=80
highlight ColorColumn ctermbg=0

" CONTROVERSIAL bindings!
" Rebind $ and ^ for moving to begin and end of line 
nnoremap B ^
nnoremap E $
nnoremap $ <nop>
nnoremap ^ <nop>

" Use jk as escape when typed in insert mode.
" If you ever actually wish to type jk then type j, wait then k.
inoremap jk <esc>
"------------------------------------------------------------
" Indentation options {{{1
"
" Indentation settings according to personal preference.
 
" Indentation settings for using 4 spaces instead of tabs.
" Do not change 'tabstop' from its default value of 8 with this setup.
set shiftwidth=4
set softtabstop=4
set expandtab
 
" Indentation settings for using hard tabs for indent. Display tabs as
" four characters wide.
"set shiftwidth=4
"set tabstop=4
 
 
"------------------------------------------------------------
" Mappings {{{1
"
" Useful mappings
 
" Map Y to act like D and C, i.e. to yank until EOL, rather than act as yy,
" which is the default
map Y y$
 
" Map <C-L> (redraw screen) to also turn off search highlighting until the
" next search
nnoremap <C-L> :nohl<CR><C-L>

" Don't use arrow keys
noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>
"------------------------------------------------------------

"------------------------------------------------------------
" YouCompleteMe
let g:ycm_autoclose_preview_window_after_insertion = 1
"py3 << EOF
"import os
"import sys
"import site
"
"if 'VIRTUAL_ENV' in os.environ:
"    # Get the base directory of the virtual environment.
"    base_dir = os.environ['VIRTUAL_ENV']
"
"    # Prepend the bin directory to the path.
"    bin_dir = base_dir + '/bin'
"    os.environ['PATH'] = os.pathsep.join([bin_dir] + \
"                         os.environ.get("PATH", "").split(os.pathsep))
"
"    # Add virtual environment site-packages to host python.
"    IS_PYPY = hasattr(sys, "pypy_version_info")
"    IS_JYTHON = sys.platform.startswith("java")
"    if IS_JYTHON:
"        site_packages = os.path.join(base_dir, "Lib", "site-packages")
"    elif IS_PYPY:
"        site_packages = os.path.join(base_dir, "site-packages")
"    else:
"        IS_WIN = sys.platform == "win32"
"        if IS_WIN:
"            site_packages = os.path.join(base_dir, "Lib", "site-packages")
"        else:
"            site_packages = os.path.join(base_dir, "lib",
"                "python%s" % sys.version[:3], "site-packages")
"
"    prev = set(sys.path)
"    site.addsitedir(site_packages)
"    sys.real_prefix = sys.prefix
"    sys.prefix = base_dir
"
"    # Move added items to front of path in place.
"    new = list(sys.path)
"    sys.path[:] = [i for i in new if i not in prev] + \
"                  [i for i in new if i in prev]
"
"EOF

"------------------------------------------------------------
" Ale
let g:ale_linters = {'python': ['flake8', 'pylint']}
let g:ale_virtualenv_dir_names = ['.env', 'env', 've-py3', 've', 'virtualenv', 'venv', 'citadel_env']
let g:ale_use_global_executables = 0

"------------------------------------------------------------
" UltiSnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<c-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"------------------------------------------------------------
" Fzy (fuzzy search)
function! FzyCommand(choice_command, vim_command)
  try
    let output = system(a:choice_command . " | fzy ")
  catch /Vim:Interrupt/
    " Swallow errors from ^C, allow redraw! below
  endtry
  redraw!
  if v:shell_error == 0 && !empty(output)
    exec a:vim_command . ' ' . output
  endif
endfunction

nnoremap <leader>e :call FzyCommand("find -type f", ":e")<cr>
nnoremap <leader>v :call FzyCommand("find -type f", ":vs")<cr>
nnoremap <leader>s :call FzyCommand("find -type f", ":sp")<cr>

"------------------------------------------------------------
" argwrap
nnoremap <silent> <leader>a :ArgWrap<CR>
