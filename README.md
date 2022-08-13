# Toop

Toop stands for Text Objects OPerations.
It allows you to send text objects to functions or to the shell using Vim's native lingo.


Toop allows to add behavior equivalent to the native `d` part in `dap` or `dis` (delete a paragraph or inside a sentence).

Actually let's build that:

```vim
call toop#mapShell('return', '<leader>d')
```

Done! It works like the native `d`.

## Examples


### toop#mapShell

mapShell sends the text object directly to the shell stdin

```vim
"make json objects beautiful
call toop#mapShell('jq .', '<leader>jq')
"make cool graphs
call toop#mapShell('graph-easy', 'mg')
"translate german to english
call toop#mapShell('trans -b  -no-theme -no-auto -no-ansi de:en', '<leader>ge')
"make markdown numbered list
call toop#mapShell("awk 'BEGIN { c=1 } // { print c\". \"$0; c = c+1 }'", '<leader>nl')
"base 64 encode
call toop#mapShell('base64', '64e')
```

### toop#mapFunction

mapFunction sends the text object as the only argument to the function you defined.

```vim
"using vim functions
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

- with a text object `is<leader>jb`
- repeat the operations over text  objects with the  `.` (dot)
- with the current line by repeat the last key of the stroke `<leader>jbb`
- After a visual selection `<C-v><leader>jb`

**Want more?** Check the ideas in the [wiki](https://github.com/jeanCarloMachado/vim-toop/wiki/usage-ideas).

## Installation


Use your favourite package manager:
```vim
Plug 'jeanCarloMachado/vim-toop'
```

## Exponential functionality out of the box

By adding a new operation with toop you get it for all text objects. And
when you add new text objects you get all operations for free. This is
the most native way of extending your Vim.

These plugins complement toop nicely by allowing you to create new text objects:

 - [kana/vim-textobj-user](https://github.com/kana/vim-textobj-user): easily create your own text objects
 - [kana/vim-textobj-function](https://github.com/kana/vim-textobj-function): treats a function as a text object
 - [michaeljsmith/vim-indent-object](https://github.com/michaeljsmith/vim-indent-object): uses the lines at the current indentation as a text object
 - [vim-scripts/argtextobj.vim](https://github.com/vim-scripts/argtextobj.vim): uses a function  argument as an text object

## Acknowledgments

Another meaning for this project name is [Tim pOpe](https://github.com/tpope) Original Project.

The original code snippet came from one of his projects where it was used as auxiliary functionality.
Since there's only a code snippet [hanging around](http://vim.wikia.com/wiki/Act_on_text_objects_with_custom_functions) the internet I decided to create a proper project and work on the idea.

And here is the result! Let me know your thoughts.

## Roadmap

1. Add async support
2. Results in preview pane

## Q&A

*What is a text-object?*
    Instead of editing character by is much more efficient to edit by word, sentence, and paragraph. In Vim, these higher-level concepts are called text objects.  But in the end just a block of text. If you want to go deeper take a look at [this post](https://blog.carbonfive.com/2011/10/17/vim-text-objects-the-definitive-guide/) and also the official documentation `:h text-object`.

More questions? Checkout the [Q&A](https://github.com/jeanCarloMachado/vim-toop/wiki/q&a).
