call plug#begin()

Plug 'morhetz/gruvbox'

" :ConjureSchool
Plug 'Olical/conjure'

" mrepl / grapple
Plug 'Olical/nfnl'
Plug 'pyrmont/grapple', { 'rtp': 'res/plugins/grapple.nvim' }

Plug 'bakpakin/janet.vim'

call plug#end()

" use mrepl / grapple
let g:conjure#filetype#janet = 'grapple.client'

"-- adapted:
"--   https://github.com/janet-lang/janet.vim/blob/master/ftdetect/janet.vim
"-- au BufRead,BufNewFile *.janet,*.jdn setlocal filetype=janet

colorscheme gruvbox

set number

" conjure's recommendation
let maplocalleader = ','

