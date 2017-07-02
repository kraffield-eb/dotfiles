" enable python plugins for neovim using neovim's own pyenv
let g:python_host_prog =$HOME . '/.pyenv/versions/neovim2/bin/python'
let g:python3_host_prog =$HOME . '/.pyenv/versions/neovim3/bin/python'


call plug#begin()

    Plug 'w0rp/ale'  " lint engine
    Plug 'janko-m/vim-test'  " test runner engine
    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
    Plug 'zchee/deoplete-jedi'
    Plug 'sebastianmarkow/deoplete-rust'
    Plug 'tpope/vim-fugitive'
    Plug 'tpope/vim-rhubarb'
    Plug 'tpope/vim-surround'
    Plug 'fatih/vim-go', { 'tag': '*' }
    Plug 'bling/vim-airline'
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
    Plug 'mitermayer/vim-prettier', {'do': 'yarn install', 'for': ['javascript', 'typescript', 'css', 'less', 'scss']}

    " syntax color plugins and indent plugins
    Plug 'trevordmiller/nova-vim'
    Plug 'pangloss/vim-javascript'
    Plug 'othree/html5.vim'
    Plug 'hail2u/vim-css3-syntax'
    Plug 'mxw/vim-jsx'
    Plug 'rust-lang/rust.vim'

call plug#end()


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
let g:ale_fixers = {
    \ 'javascript': ['eslint']
    \ }

" enable deoplete, set tab complettion remap, close scratch window automatically
let g:deoplete#enable_at_startup = 1
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif

" status line vim airline config
let g:airline#extensions#tabline#enabled = 1

" vim-javascript config
let g:javascript_plugin_flow = 1  " enable javascript flow shit to be highlighted correctly
let g:prettier#exec_cmd_async = 1  " enable async js / css code formatting through prettier
let g:prettier#autoformat = 0
autocmd BufWritePre *.js,*.css,*.scss,*.less PrettierAsync  " runs prettier before saving


" vim-test config
let test#strategy = "neovim"  " runs test in :term instead of :!

" rust config
let g:rustfmt_autosave = 1
let g:deoplete#sources#rust#racer_binary='~/.cargo/bin/racer'
let g:deoplete#sources#rust#rust_source_path='~/.multirust/toolchains/stable-x86_64-apple-darwin/lib/rustlib/src/rust/src'
" let g:deoplete#sources#rust#documentation_max_height=20


" -- Normal Mode Remaps
nnoremap <leader>r :call NumberToggle()<cr>
nnoremap <leader>j :bn<cr>
nnoremap <leader>k :bp<cr>
nnoremap <leader>T :vsplit term://bash<cr>a. ~/.bash_profile<cr>
nnoremap <leader>Th :sp term://bash<cr>a. ~/.bash_profile<cr>
nnoremap <leader>tt :TestFile<cr>

" -- Terminal Mode Remaps
:tnoremap <Esc> <C-\><C-n>  " press escape to get into normal mode

" -- Visual Mode Remaps
vmap <leader>cc :'<,'>:w !pbcopy<CR>

" -- misc settings
set number
set relativenumber
set nojoinspaces
set splitright
set scrolloff=3
set sidescrolloff=5
set hidden
colorscheme nova

" -- highlight trailing whitespace and tab characters in darkgreen
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

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
