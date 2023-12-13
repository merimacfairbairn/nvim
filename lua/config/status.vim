" Status-bar color scheme
hi User1 guifg=#d79921 guibg=#3c3836
hi User2 guifg=#fb4924 guibg=#3c3836
hi User3 guifg=#b8bb26 guibg=#3c3836

" Status-bar configuration
set statusline=%2*%2M%*                " Modified flag
set statusline+=%1*\ %n%*              " Buffer number
set statusline+=%3*\ %<%F%*            " Full path

set statusline+=%1*%=%*                " Switch to the right side

set statusline+=%3*\ %Y%*              " File type
set statusline+=%1*%5l%*               " Current line
set statusline+=%2*/%L%*               " Total lines
set statusline+=%1*%4v\ %*             " Virtual column number

set wildmenu                           " Tab completion as a menu
set wildmode=list:longest              " Make it look like Bash completion
set wildignore=*.docx,*.jpg,*.png,*.gif,*.pdf,*pyc,*.e  " Exceptions
set laststatus=2                       " Always display status bar

" Highlight trailing whitespace
hi TrailingWhitespace ctermbg=red guibg=#fb4934
call matchadd("TrailingWhitespace", '\v\s+$')
