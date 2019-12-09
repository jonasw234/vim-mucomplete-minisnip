# vim-mucomplete-minisnip
Makes [Minisnip](https://github.com/joereynolds/vim-minisnip) snippets available as a completion chain in [µcomplete](https://github.com/lifepillar/vim-mucomplete).

## Installation
Add the following to your .vimrc:
`let mucomplete#user_mappings          = {'minisnip': "\<C-r>=MUcompleteMinisnip#complete()\<CR>"}`
and add the `minisnip` chain somewhere to your completion chains.
Use a plugin manager or manual installation to add “MUcompleteMinisnip.vim” to your autoload directory.

If you want to use multiple directories for your snippets, you can use a separator in your `minisnip_dir` definition.  By default this is `;` on Windows and `:` otherwise.  However you can choose your own by defining `g:pathsep`.
