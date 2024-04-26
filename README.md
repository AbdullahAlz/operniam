# AbdiCode
### Overview
`This repository consists of many independent single small programs, nothing of use unless you know what you are looking for`

If any future program in this repository becomes useful enough to be cared about, feel free to use it, but do not expect it to be perfect, nothing here is.

There follows a chronological list of the programs in this repository with a brief description.

## `ackermann.c`
This is a basic C implementation of the deeply recursing 
[ackermann function](https://en.wikipedia.org/wiki/Ackermann_function)

Usage after Compilation: 
`./ackermann <a> <b>`
    
This can blow up very quickly:

    ackermann(4, 0) = 13
    ackermann(5, 0) = 65533

## `remover.c`
This is an interesting program, it finds the **last** occurrence of a given string in every line of a text file and removes the contents of that line up to, and including, that String:

    String = "/"
    Any line = /folder1/folder2/file_x
    Output: file_x

Ironically, the program does what a simple combination of `find(1)` with `sed(1)` would have done more efficiently: 

> ` find / | sed 's|.*/||'`

This command does the same as:
> `find / > output`\
> `./remover output / && cat result.txt`

After finding out about `sed`, this program becomes entirely obsolete.

Usage after Compilation: `./remover <PathToFile> <StringToRemove>`

## `perfectNumber.py`
For some given number of iterations, all even perfect numbers are calculated, using the same old boring method.
> For a prime number `p`, if $$(2^p-1)$$ is prime, then $$2^{p-1}(2^p-1)$$ is perfect
