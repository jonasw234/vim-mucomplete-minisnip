# vim-mucomplete-minisnip
Makes [Minisnip](https://github.com/joereynolds/vim-minisnip) snippets available as a completion chain in [µcomplete](https://github.com/lifepillar/vim-mucomplete).

## Installation
Add the following to your .vimrc:
`let mucomplete#user_mappings          = {'minisnip': "\<C-r>=MUcompleteMinisnip#complete()\<CR>"}`
and add the `minisnip` chain somewhere to your completion chains.
Use a plugin manager or manual installation to add “MUcompleteMinisnip.vim” to your autoload directory.
