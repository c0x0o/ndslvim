" NOTE: use vim-plug to manage plugins

set nocompatible
filetype off " required! turn off

function LoadLanguageSupport()
  if exists("g:ignore_language_support")
    return 0
  else
    return 1
  endif
endfunction

call plug#begin('~/.config/nvim/bundle')
" ====================== plugin definition ==========================

" airline
" a light weight status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ctrlP
" a great fuzzy buffer finder, toggle with '<leader>f'
Plug 'ctrlpvim/ctrlp.vim'

" TheNerdTree
" a filesystem tree viewer, toggle with '<C-n>'
Plug 'scrooloose/nerdtree'

" emmet
" famous emmet! use '<C-e>' to expand
Plug 'mattn/emmet-vim'

" nerdcommenter
" auto comment, '[count]<leader>c<space>' to toggle
Plug 'scrooloose/nerdcommenter'

" vim-trailing-whitespace
" mark spare white space and use '<leader><space>' to fix it (globally).
Plug 'bronson/vim-trailing-whitespace'

" delimitmate
" complete pair symbol such as (), {} etc
Plug 'raimondi/delimitmate'

" matchit
" extending % matching in HTML, Latex and other language
Plug 'vim-scripts/matchit.zip'

" theme
Plug 'kien/rainbow_parentheses.vim'         " for parentheses
Plug 'lifepillar/vim-solarized8'
Plug 'tomasr/molokai'

" git tools
"
" vim-gitgutter
" show and switch between the changes in your files
Plug 'airblade/vim-gitgutter'
" fugitive
" git wrapper inner vim
Plug 'tpope/vim-fugitive'

" ** LANGUAGE SUPPORT **
if LoadLanguageSupport()
  " LanguageClient
  " https://github.com/neoclide/coc.nvim
  Plug 'neoclide/coc.nvim', {'tag': '*', 'do': { -> coc#util#install()}}
endif " LoadLanguageSupport

" ==================== plugin definition end ========================
call plug#end()

" ==================== configuration ================================
" hints:
" 1. use /pluginName to search its config

" airline {{{
    if !exists('g:airline_symbols')
        let g:airline_symbols = {}
    endif

    let g:airline_theme='luna'
    let g:airline#extensions#tabline#enabled = 1
    let g:airline#extensions#tabline#show_buffers = 0

    " unicode symbols
    let g:airline_left_sep = ''
    let g:airline_right_sep = ''
    let g:airline_symbols.crypt = '🔒'
    let g:airline_symbols.linenr = '☰'
    let g:airline_symbols.linenr = '␊'
    let g:airline_symbols.linenr = '␤'
    let g:airline_symbols.linenr = '¶'
    let g:airline_symbols.maxlinenr = ''
    let g:airline_symbols.maxlinenr = '㏑'
    let g:airline_symbols.branch = '⎇'
    let g:airline_symbols.paste = 'ρ'
    let g:airline_symbols.paste = 'Þ'
    let g:airline_symbols.paste = '∥'
    let g:airline_symbols.spell = 'Ꞩ'
    let g:airline_symbols.notexists = '∄'
    let g:airline_symbols.whitespace = 'Ξ'

    " co-op with fugitive
    let g:airline#extensions#branch#enabled = 1
    let g:airline#extensions#branch#empty_message = 'no branch info'

    " co-op with gitgutter
    let g:airline#extensions#hunks#enabled = 1
    let g:airline#extensions#hunks#hunk_symbols = ['+', '~', '-']
" }}}

" ctrlP {{{
    " Setup some default ignores
    let g:ctrlp_custom_ignore = {
                \ 'dir':  '\v[\/]((\.(git|hg|svn)|\_site)|node_modules|bower_modules|build)$',
                \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg|tar|tar.gz|tar.bz2|pyc|o)$',
                \}
    let g:ctrlp_show_hidden = 1

    " use nearest folder which has a version control info(.svn, .git) as the
    " root, or the current directory
    let g:ctrlp_working_path_mode = 'ra'
    let g:ctrlp_root_markers = ['Makefile', 'makefile']

    " activate ctrlP
    let g:ctrlp_map = '<C-f>'
    let g:ctrlp_cmd = 'CtrlP'

    " key map
    nmap <leader>bb :CtrlPBuffer<cr>
    nmap <leader>bm :CtrlPMixed<cr>
    nmap <leader>bs :CtrlPMRU<cr>

" }}}

" TheNerdTree {{{
    map <C-n> :NERDTreeToggle<CR>
    let NERDTreeHighlightCursorline=1
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$' ]
    "close vim if the only window left open is a NERDTree
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
    " s/v split open
    let g:NERDTreeMapOpenSplit = 's'
    let g:NERDTreeMapOpenVSplit = 'v'
" }}}

" emmet {{{
    let g:user_emmet_expandabbr_key = '<C-e>'
"   let g:user_emmet_leader_key='<C-e>'
" }}}

" nerdcommenter {{{
    let g:NERDSpaceDelims=1
    let g:NERDAltDelims_python = 1
" }}}

" trailingwhitespace {{{
    nnoremap <leader><space> :FixWhitespace<cr>
" }}}


" delimitmate {{{
" }}}

" matchit {{{
" }}}

" rainbow_parentheses {{{
    let g:rbpt_colorpairs = [
        \ ['brown',       'RoyalBlue3'],
        \ ['Darkblue',    'SeaGreen3'],
        \ ['darkgray',    'DarkOrchid3'],
        \ ['darkgreen',   'firebrick3'],
        \ ['darkcyan',    'RoyalBlue3'],
        \ ['darkred',     'SeaGreen3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['brown',       'firebrick3'],
        \ ['gray',        'RoyalBlue3'],
        \ ['darkmagenta', 'DarkOrchid3'],
        \ ['Darkblue',    'firebrick3'],
        \ ['darkgreen',   'RoyalBlue3'],
        \ ['darkcyan',    'SeaGreen3'],
        \ ['darkred',     'DarkOrchid3'],
        \ ['red',         'firebrick3'],
        \ ]

    let g:rbpt_max = 16
    let g:rbpt_loadcmd_toggle = 0
    au VimEnter * RainbowParenthesesToggle
    au Syntax * RainbowParenthesesLoadRound
    au Syntax * RainbowParenthesesLoadSquare
    au Syntax * RainbowParenthesesLoadBraces
" }}}

" molokai {{{
    let g:molokai_original = 1
    let g:rehash256 = 1
" }}}

" solarized8 {{{
" }}}

" vim-gitgutter {{{
    " disable its own key mapping
    let g:gitgutter_map_keys = 0
    nnoremap <leader>n :GitGutterNextHunk<CR>
    nnoremap <leader>N :GitGutterPrevHunk<CR>
" }}}

" fugitive {{{
" }}}

if LoadLanguageSupport()
  " coc.nvim
  " {{{
      call coc#config('languageserver', {
        \   "ccls": {
        \     "command": $HOME."/.config/nvim/lang-server/ccls/Release/ccls",
        \     "filetypes": ["c", "cpp", "cuda", "objc", "objcpp", "cc"],
        \     "rootPatterns": [".ccls", "compile_commands.json", ".vim/", ".git/", ".hg/", "WORKSPACE"],
        \     "initializationOptions": {
        \       "cache": {
        \         "directory": "/tmp/ccls"
        \       }
        \     }
        \   }
        \})
      nmap gd :call CocAction('jumpDefinition')<CR>
      nmap gh :call CocAction('jumpReferences')<CR>

  "   use tab and s-tab to navigate, use enter to complete
      inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
      inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
      inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
      autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif
  " }}}
endif

" ==================== configuration end ============================

