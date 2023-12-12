call plug#begin('~/.local/share/nvim/plugged')

" Status bar
Plug 'nvim-lualine/lualine.nvim'
" If you want to have icons in your statusline choose one of these
Plug 'kyazdani42/nvim-web-devicons'

" Buffer bar
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }

" Tree explorer
Plug 'kyazdani42/nvim-tree.lua'

" Themes
Plug 'arcticicestudio/nord-vim'
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'lifepillar/vim-solarized8'
Plug 'cormacrelf/vim-colors-github'
Plug 'drewtempelmeyer/palenight.vim'
" Treesiter support
Plug 'navarasu/onedark.nvim'

" Languages
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Helpers
Plug 'tpope/vim-surround'
Plug 'jiangmiao/auto-pairs'

" Fuzzy search
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'
Plug 'fannheyward/telescope-coc.nvim'

" Show git changes
Plug 'airblade/vim-gitgutter'
" Editconfig
Plug 'editorconfig/editorconfig-vim'
" Code completition
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Comments
Plug 'preservim/nerdcommenter'
" CSS Color Highlight
Plug 'ap/vim-css-color'
"Plug 'yggdroot/indentLine'
"Plug 'lukas-reineke/indent-blankline.nvim'

call plug#end()

"" Set properties
set encoding=UTF-8
" Move unsave buffers
set hidden
" Show command preview
set inccommand=split
" Set tab columns = 4
set tabstop=4
" Ident 2 by 2 
set shiftwidth=2
" Change tab to spaces
set expandtab
" Incremental search
set incsearch
" Ignore case when searching
set ignorecase
" Ignore case when searching lowercase
set smartcase
" Auto indent
set smartindent
set updatetime=250
" Use mouse all modes
set mouse=a
" Scroll before end of file
set scrolloff=8
"set nohlsearch
set colorcolumn=100

" Theming
set termguicolors
set background=dark
syntax on
"let ayucolor = "mirage" " dark light mirage
"let g:onedark_termcolors=16
let gruvbox_contrast_dark = "medium" " soft medium hard
"colorscheme onedark
" Make background transparent
"highlight Normal guibg=NONE
" show chars
"set list
set listchars=tab:→\ ,trail:∙,eol:¬
let g:indentLine_char = '|'
" Highlight cursor position
set cursorline
"
" LightLine
set noshowmode
set showtabline=2

" Display
" Number lines
set number
set relativenumber

" Keybinds
" Map leader to Space
let mapleader="\<space>"

" Edit and load neovim config
nnoremap <leader>ev :vsplit ~/.config/nvim/init.vim<CR>
nnoremap <leader>sv :source ~/.config/nvim/init.vim<CR>

" Remap Esc
imap jk <esc>

" Save with Ctrl-s
nnoremap <C-s> :<c-u>update<cr>
vnoremap <C-s> <c-c>:update<cr>gv
inoremap <C-s> <c-o>:update<cr>

" Replace current word
nnoremap <leader>r *``cgn
nnoremap <leader>R #``cgN

" File Explorer
nnoremap <leader>op :NvimTreeToggle<CR>

" Search files and occurrencies
"nnoremap <C-p> :GFiles --cached --others --exclude-standard<CR>
"nnoremap <leader>f :Rg<space>
nnoremap <leader>p <cmd>lua require('telescope.builtin').find_files({previewer = false})<cr>
nnoremap <leader>f <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>, <cmd>lua require('telescope.builtin').buffers({previewer = false})<cr>

"" Buffers settings
" Close
nnoremap <leader>bk :bd<CR>
nnoremap <leader>bK :%bd!<CR>
" Next Previous
nnoremap ]b :bn<CR>
nnoremap [b :bp<CR>

" Git Gutter
let g:gitgutter_map_keys = 0
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nmap <leader>gr <Plug>(GitGutterUndoHunk)
nmap <leader>g] <Plug>(GitGutterNextHunk)
nmap <leader>g[ <Plug>(GitGutterPrevHunk)

" Copy from clipborad
vnoremap Y "+y<CR>

"" Coc configs
let g:coc_global_extensions = [ 'coc-snippets' ]
" Trigger auto completition manually
inoremap <expr> <c-space> coc#refresh()
nnoremap <leader>cd <Plug>(coc-definition)
nnoremap <leader>cD <Plug>(coc-references)
nnoremap <leader>cr <Plug>(coc-rename)
nnoremap <leader>ca <Plug>(coc-codeaction)
nnoremap <leader>cj :Telescope coc document_symbols<CR>

nnoremap <leader>cs :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Remove search highlight 
nnoremap <leader>th :nohl<CR>

"" Lua scripts
lua << END
require('onedark').load()
require('lualine').setup()
require('bufferline').setup()
require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = {
    "html", "css", "javascript", "typescript", "json", "yaml", "elixir", "dart"
    },

  -- Install parsers synchronously (only applied to `ensure_installed`)
  sync_install = false,

  -- List of parsers to ignore installing (for "all")
  ignore_install = { "" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,

    -- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
    -- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
    -- the name of the parser)
    -- list of language that will be disabled
    disable = { "" },

    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = true,
  },
}
require('nvim-tree').setup({
view = {
  side = "right",
  adaptive_size = true,
  }
})
require('telescope').load_extension('coc')
END
