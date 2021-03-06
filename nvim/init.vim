" defaults to load before plugins
" plugins can override these for stuff where it makes sense
set ts=4


" enable python plugins for neovim using neovim's own pyenv
let g:python_host_prog = $PYENV_ROOT . '/versions/neovim2/bin/python'
let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'


call plug#begin()

    Plug 'w0rp/ale'
    Plug 'janko-m/vim-test'
    Plug 'roxma/nvim-completion-manager'
    Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
    Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'Shougo/neosnippet'
    Plug 'Shougo/neosnippet-snippets'
    Plug 'zchee/deoplete-jedi'
	Plug 'davidhalter/jedi-vim'
    " Plug 'sebastianmarkow/deoplete-rust'
	Plug 'wellle/tmux-complete.vim'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-surround'
    Plug 'scrooloose/nerdcommenter'
    Plug 'fatih/vim-go', { 'tag': '*' }
    Plug 'bling/vim-airline'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'mitermayer/vim-prettier', {'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss']}

    " syntax color plugins and indent plugins
    Plug 'trevordmiller/nova-vim'
    Plug 'dag/vim-fish'
    Plug 'pangloss/vim-javascript'
    Plug 'othree/html5.vim'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'mxw/vim-jsx'
    Plug 'rust-lang/rust.vim'

call plug#end()

let g:jedi#completions_enabled = 1  " use deoplete for completions
let g:deoplete#enable_at_startup = 1

" / search config
set ignorecase
set smartcase
set magic
nnoremap <silent> <Esc> :nohlsearch<Bar>:echo<CR>


" rg fzf config
let g:rg_command = '
			\ rg --column --line-number --no-heading --fized-strings --ignore-case --no-ignore --hidden --follow --color "always"
			\ -g "!{.git,node_modules,vendor}/*" '
command! -bang -nargs=* F call fzf#vim#grep(g:rg_command .shellescape(<q-args>), 1, <bang>0)
nmap <C-p> :Files<cr>
let g:fzf_action = {'ctrl-s': 'vsplit' }
let g:fzf_layout = { 'down': '~20%' }

" lint engine configuration options
let g:ale_sign_column_always = 1
let g:ale_fix_on_save = 1
let g:ale_linters = {'rust': ['rls']}
let g:ale_fixers = {
    \ 'javascript': ['eslint'],
    \ 'python': ['yapf'],
    \ }

nmap <silent> <C-j> :cn<CR>
nmap <silent> <C-k> :cp<CR>

" neosnippet config
imap <C-i> <Plug>(neosnippet_expand_or_jump)
smap <C-i> <Plug>(neosnippet_expand_or_jump)
xmap <C-i> <Plug>(neosnippet_expand_target)
let g:neosnippet#snippets_directory='~/dotfiles/nvim/snippets'

" status line vim airline config
let g:airline#extensions#tabline#enabled = 1

" nerd comment config
let g:NERDSpaceDelims = 1
let g:NERDTrimTrailingWhitespace = 1

" vim-javascript config
let g:javascript_plugin_flow = 1  " enable javascript flow shit to be highlighted correctly
let g:prettier#exec_cmd_async = 1  " enable async js / css code formatting through prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.css,*.scss,*.less PrettierAsync  " runs prettier before saving


" vim-test config
let test#strategy = "neovim"  " runs test in :term instead of :!

" rust language specific config
let g:rustfmt_autosave = 1
let g:racer_cmd='~/.cargo/bin/racer'
" let g:deoplete#sources#rust#racer_binary=$HOME . '/.cargo/bin/racer'
" let g:deoplete#sources#rust#rust_source_path=$HOME . '/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
" let g:deoplete#sources#rust#documentation_max_height=20

augroup rust
	autocmd!
	autocmd FileType rust nnoremap <leader>rr :term cargo run<cr>
	autocmd FileType rust nnoremap <leader>bb :term cargo build<cr>
	autocmd FileType rust nnoremap <leader>qb :term cargo check<cr>
	"use vim-test autocmd FileType rust nnoremap <leader>tt :term cargo test<cr>
augroup END


" -- Normal Mode Remaps
nnoremap <leader>j :bn<cr>
nnoremap <leader>k :bp<cr>
nnoremap <leader>T :vsplit term://bash<cr>a. ~/.bash_profile<cr>
nnoremap <leader>Th :sp term://bash<cr>a. ~/.bash_profile<cr>
nnoremap <leader>tt :TestFile<cr>

" -- Terminal Mode Remaps
:tnoremap <Esc> <C-\><C-n>  " press escape to get into normal mode

" -- Visual Mode Remaps
vmap <leader>cp :'<,'>:w !pbcopy<cr><cr>

" -- misc settings
set number
set relativenumber
set nojoinspaces
set splitright
set scrolloff=3
set sidescrolloff=5
set hidden
colorscheme nova

"###FUNCTIONS###
"###############
function! NumberToggle()
  if(&relativenumber == 1)
    set nornu
    set number
  else
    set rnu
  endif
endfunc
command! NumToggle call NumberToggle()

function! AleFixersToggle()
		let g:ale_fix_on_save = exists('g:ale_fix_on_save') ? !g:ale_fix_on_save : 1
endfunc
command! ToggleFixers call AleFixersToggle()
