# Toop demonstration

Let's create a translation mappings using translate-shell

```vim
call toop#mapShell('trans -b  -no-theme -no-auto -no-ansi en:de', '<leader>ed')
call toop#mapShell('trans -b  -no-theme -no-auto -no-ansi en:fr', '<leader>ef')
```

Now let's translate inside a sentence (is)

    One sentence. Middle sentence. Another sentence.


Or a paragraph (ap)


    One sentence. Middle sentence. Another sentence.

    One sentence. Middle sentence. Another sentence.


Actually any text object works.

We can also repeat:


    One sentence. Middle sentence. Another sentence.

Use awk to make a numbered list
