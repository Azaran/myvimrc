syntax on


" start NERDTree by default
" autocmd VimEnter * NERDTree
autocmd VimEnter * wincmd p
 
" visual setting "
filetype on
filetype plugin on
filetype indent on

let g:solarized_termcolors=16
set t_Co=16
set background=dark
colorscheme solarized

set encoding=utf-8
set fileformat=unix

set number
set relativenumber
set linebreak	
set showbreak=+++
set textwidth=80
set showmatch	
set visualbell	
 
set hlsearch
set smartcase
set ignorecase
set incsearch
 
set autoindent
set cindent	
set shiftwidth=4
set smartindent	
set smarttab	
set softtabstop=4
 
set matchpairs+=<:>
set ruler	
 
set undolevels=1000
set backspace=indent,eol,start

set foldmethod=syntax

set wmh=0

" `gf` opens file under cursor in a new vertical split
nnoremap gf :vertical wincmd f<CR>

" Navigation between open windows
map <C-J> <C-W>j
map <C-K> <C-W>k
map <C-H> <C-W>h
map <C-L> <C-W>l
" Ctrl-i inserts one char and exits to normal mode
map <C-i> i_<Esc>
" Map :make to \j
map <Leader>j :silent make\|redraw!\|cc<CR>

" list of disabled plugins
let g:pathogen_disabled = []
execute pathogen#infect()

au BufNewFile,BufRead *.cl set filetype=c

" http://vim.wikia.com/wiki/C%2B%2B_code_completion
" omniCPP
set nocp
" configure tags - add additional tags here or comment out not-used ones
set tags+=~/.vim/tags/cpp
set tags+=~/.vim/tags/gl
set tags+=~/.vim/tags/sdl
set tags+=~/.vim/tags/qt4

"" OmniCppComplete
let OmniCpp_NamespaceSearch = 1
let OmniCpp_GlobalScopeSearch = 1
let OmniCpp_ShowAccess = 1
let OmniCpp_ShowPrototypeInAbbr = 1 " show function parameters
let OmniCpp_MayCompleteDot = 1 " autocomplete after .
let OmniCpp_MayCompleteArrow = 1 " autocomplete after ->
let OmniCpp_MayCompleteScope = 1 " autocomplete after ::
let OmniCpp_DefaultNamespaces = ["std", "_GLIBCXX_STD"]
" automatically open and close the popup menu / preview window
au CursorMovedI,InsertLeave * if pumvisible() == 0|silent! pclose|endif
set completeopt=menuone,menu,longest,preview

" Update tags on file save asynchronously
autocmd BufWritePost * if &filetype == 'cpp' | silent exe ":!(ctags -R --c++-kinds=+p --fields=+iaS --extra=+q . &)" | endif

" AutoPair FlyMode
let g:AutoPairsFlyMode = 0
let g:AutoPairsShortcutBackInsert = '<M-b>'

" Map Alt to <ESC> with timeout
let c='a'
while c <= 'z'
    exec "set <A-".c.">=\e".c
    exec "imap \e".c." <A-".c.">"
    let c = nr2char(1+char2nr(c))
endw
set ttimeout ttimeoutlen=30
" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.
"
" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens it
" (but not if it's already open). However, as part of the autocmd, this doesn't
" seem to happen.
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow


" Doxygen toolkit settings plus needed mapping of :Dox to Alt-D
nnoremap <A-d> :Dox<CR>
let g:DoxygenToolkit_briefTag_pre="@brief   "
let g:DoxygenToolkit_paramTag_pre="@param "
let g:DoxygenToolkit_returnTag=   "@return  "
let g:DoxygenToolkit_blockHeader="-------------------------------"
let g:DoxygenToolkit_blockFooter="---------------------------------"
let g:DoxygenToolkit_authorName="Vojtech Vecera"
let g:DoxygenToolkit_compactDoc = "yes"

" Alt-j/k inserts new line below/above
function! AddEmptyLineBelow()
  call append(line("."), "")
endfunction

function! AddEmptyLineAbove()
  let l:scrolloffsave = &scrolloff
  " Avoid jerky scrolling with ^E at top of window
  set scrolloff=0
  call append(line(".") - 1, "")
  if winline() != winheight(0)
    silent normal! <C-e>
  end
  let &scrolloff = l:scrolloffsave
endfunction

noremap <silent> <A-j> :call AddEmptyLineBelow()<CR>
noremap <silent> <A-k> :call AddEmptyLineAbove()<CR>

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.

" IMPORTANT: win32 users will need to have 'shellslash' set so that latex
" can be called correctly.
set shellslash

" IMPORTANT: grep will sometimes skip displaying the file name if you
" search in a singe file. This will confuse Latex-Suite. Set your grep
" program to always generate a file-name.
set grepprg=grep\ -nH\ $*

" OPTIONAL: This enables automatic indentation as you type.
filetype indent on

" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'
function! OutlineToggle()
  if (! exists ("b:outline_mode"))
    let b:outline_mode = 1
  endif
  if (b:outline_mode == 0)
    syn region myFold start="{" end="}" transparent fold
    syn sync fromstart
    set foldmethod=syntax
    silent! exec "%s/{{{/<<</"
    silent! exec "%s/}}}/>>>/"
    let b:outline_mode = 1
  else
    set foldmethod=marker
    silent! exec "%s/<<</{{{/"
    silent! exec "%s/>>>/}}}/"
    let b:outline_mode = 0
  endif
endfunction

