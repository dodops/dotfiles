" ==========================
" Config For elixir-ls + COC
" ==========================

let g:elixirls = {'path': printf('%s', '~/.config/nvim/plugged/elixir-ls')}
let g:elixirls.lsp = printf('%s/%s', g:elixirls.path, 'release/language_server.sh')

function! g:elixirls.compile(...)
  let l:commands = join([
        \ 'mix local.hex --force',
        \ 'mix local.rebar --force',
        \ 'mix deps.get',
        \ 'mix compile',
        \ 'mix elixir_ls.release'
        \ ], '&&')

  echom '>>> Compiling elixirls'
  silent call system(l:commands)
  echom '>>> elixirls compiled'
endfunction

" Virgula como mapleader
let mapleader=","

" Editar configuração do NeoVim
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim <cr>

" Mapeia CTRL-P
nnoremap <leader>f :Files<cr>

autocmd!
set hidden
set number
set numberwidth=5
set relativenumber
set smarttab 
set autoindent
set ruler
set incsearch
set wildmenu
set mouse=a
set inccommand=split
set showmatch
set syntax=enable
set encoding=utf-8

" Tab config
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2

" Navegação
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

nmap <silent> // :nohlsearch<CR>

noremap <leader>sh :vsplit term://zsh<cr>

" Buff tabs
nnoremap <leader>w :bnext<CR>
nnoremap <leader>e :bd<CR>
nnoremap <Right>:vertical resize +18<CR>
nnoremap <Left>:vertical resize -18<CR>

" Tabs
nnoremap <leader>q :tabNext<CR>

" VimPlug configuration
call plug#begin('~/.local/share/nvim/plugged')

Plug 'morhetz/gruvbox'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-endwise'
Plug 'terryma/vim-multiple-cursors'
Plug 'sheerun/vim-polyglot'
Plug 'airblade/vim-gitgutter'
Plug 'mileszs/ack.vim'
Plug 'rking/ag.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Ruby
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'thoughtbot/vim-rspec'

" Markdown
Plug 'plasticboy/vim-markdown'

" Javascript Support
Plug 'pangloss/vim-javascript'

" Tmux support
Plug 'christoomey/vim-tmux-navigator'

" Elixir support
Plug 'elixir-lang/vim-elixir'

Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" AutoComplete/Snippets
Plug 'neoclide/coc.nvim', {'branch': 'release', 'do': { -> coc#util#install()  } } " Code completation
Plug 'JakeBecker/elixir-ls', { 'do': { -> g:elixirls.compile() } } " Language server for elixir
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

" Themes
Plug 'dracula/vim', {'as': 'dracula'}
Plug 'altercation/vim-colors-solarized'
Plug 'sonph/onehalf', {'rtp': 'vim/'}
Plug 'jacoborus/tender.vim'
Plug 'drewtempelmeyer/palenight.vim'
Plug 'joshdick/onedark.vim'
call plug#end()

nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

inoremap <silent><expr> <TAB>
			\ pumvisible() ? "\<C-n>" :
			\ <SID>check_back_space() ? "\<TAB>" :
			\ coc#refresh()

inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col - 1]  =~# '\s'
endfunction

inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" For conceal markers.
if has('conceal')
  set conceallevel=2 concealcursor=niv
endif

if (has("termguicolors"))
 set termguicolors
endif

set background=dark
colorscheme gruvbox
let g:airline_theme='gruvbox'
let g:solarized_termcolors=256
let g:ag_working_path_mode="r"

" Airline configuration
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Snippets keys
let g:UltiSnipsExpandTrigger="sn"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" Load other files
so ~/.config/nvim/plugconfig.vim
