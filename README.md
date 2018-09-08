# Toop

Toop stands for Text Objects OPerations.

## Mapping Examples

```vim
"make json objects beautiful
call toop#mapShell('jq .', 'jq')
call toop#mapShell('trans -b  -no-theme -no-auto -no-ansi de:en', '<leader>de')
call toop#mapShell('md5sum | cut -d " " -f1 ', '<leader>md5')
call toop#mapShell('graph-easy', '<leader>mg')

"single quote
call toop#mapAround('<', '>', '<leader><')
"markdown code block
call toop#mapAround("```sh\n", "\n```", '<leader>c')


function! Duplicate(string)
    return a:string.a:string
endfun
call toop#mapFunction('Duplicate', "<leader>2x")

fun! FoldSomething(str)
    let comment=split(&commentstring, '%s')
    if len(l:comment)==1
        call add(comment, l:comment[0])
    endif
    return l:comment[0]." {{{\n".a:str."\n".l:comment[1]."}}}"
endfun
call toop#mapFunction('FoldSomething', '<leader>fo')

fun! GoogleIt(str)
    execute 'AsyncRun $BROWSER "'.a:str.'"'
endfunc
call toop#mapFunction('GoogleIt', '<leader>gi')
```

After having mapped some behaviour you can use it in the following ways:


- After a visual selection `<C-v><leader>jb`
- with a text object `is<leader>jb`
- with the current line by repeat the last key of the stroke `<leader>jbb`
- repeat the operations over text  objects with the  `.` (dot)

Want more ideas of operations? Check my [vimrc](https://github.com/jeanCarloMachado/vimrc/blob/391f1da253a0c23414663ae0618f78ebbdbc4245/vimrc#L490).

## Installation


Use your favourite package manager:
```vim
Plug 'jeanCarloMachado/vim-toop'
```


## Exponential functionality out of the box

By adding a new operation with toop you get it for all text objects. And
when you add new text objects you get all operations for free. This is
the most native way of extending your Vim.

This plugins complement toop nicely by allowing you to create new text objects:

 - [kana/vim-textobj-user](https://github.com/kana/vim-textobj-user): easily create your own text objects
 - [kana/vim-textobj-function](https://github.com/kana/vim-textobj-function): treats a function as a text object
 - [michaeljsmith/vim-indent-object](https://github.com/michaeljsmith/vim-indent-object): uses the lines at the current indentation as a text object
 - [vim-scripts/argtextobj.vim](https://github.com/vim-scripts/argtextobj.vim): uses a function  argument as an text object


## Acknowledgments

Another meaning the project name is [Tim pOpe](https://github.com/tpope) [Original](http://vim.wikia.com/wiki/Act_on_text_objects_with_custom_functions) Project (with steroids). The core idea was extracted from a code snippet on one of his repositories.

