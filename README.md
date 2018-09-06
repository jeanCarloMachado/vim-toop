# Toop

Create custom text-object operations.  This is the most native way of extending your Vim.

Toop stands for Text Objects OPerations.

Or also [Tim pOpe](https://github.com/tpope) [Original](http://vim.wikia.com/wiki/Act_on_text_objects_with_custom_functions) Project (with extensions).

## Mapping Examples

```vim
"make json objects beautiful
call toop#mapShell('jq .', '<leader>jb')
call toop#mapShell('translate.sh en de', '<leader>le')
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


For each text object vim offers you have operations working on them. And if you create your own text objects you also get them working for free.
For each new text operation you get all text objects working on them and for each new text object all text operations work on them.

Toop is even better if you use alongside this plugins to extend your text objects:

 - [kana/vim-textobj-user](https://github.com/kana/vim-textobj-user): easily create your own text objects
 - [kana/vim-textobj-function](https://github.com/kana/vim-textobj-function): treats a function as a text object
 - [michaeljsmith/vim-indent-object](https://github.com/michaeljsmith/vim-indent-object): uses the lines at the current indentation as a text object
 - [vim-scripts/argtextobj.vim](https://github.com/vim-scripts/argtextobj.vim): uses a function  argument as an text object


