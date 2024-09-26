# AbdiCode
### Overview
`This repository consists of many independent small programs. Nothing here is of use unless you know what you are looking for`

If any future program in this repository becomes useful enough to be cared about, feel free to use it, but do not expect it to be perfect

There follows a chronological list of the programs in this repository with a brief description.

First is most recent

## `updtdsc`

This is my first bashscript.

When I moved to Linux, being a [Discord](https://discord.com/) user [(bad)](https://cadence.moe/blog/2020-06-06-why-you-shouldnt-trust-discord), I had to suffer with updates. Whenever a new Discord update comes out, you have to download a .deb file and install it. So instead of doing that manually every time, I wrote this script, which:

- downloads the newest stable Discord version for Debian (.deb)
- compares the version with the existing one
- installs the downloaded version if it is a new one
- removes the .deb file


## `perfectNumber.py`
For some given number of iterations, all even perfect numbers are calculated, using the same old boring method.
> For a prime number `p`, if $$(2^p-1)$$ is prime, then $$2^{p-1}(2^p-1)$$ is perfect

## `remover.c`

This is an interesting program, it finds the **last** occurrence of a given string in every line of a text file and removes the contents of that line up to, and including, that String:

    String = "/"
    Any line = /folder1/folder2/file_x
    Output: file_x

Ironically, the program does what a simple combination of `find(1)` with `sed(1)` would have done more efficiently: 

` find / | sed 's|.*/||'`

This command does the same as:

`find / > output`\
`./remover output / && cat result.txt`

After finding out about the existence of `sed`, this program becomes entirely obsolete.

Usage after Compilation: `./remover <PathToFile> <StringToRemove>`


## `ackermann.c`
This is a basic C implementation of the deeply recursing 
[ackermann function](https://en.wikipedia.org/wiki/Ackermann_function)

Usage after Compilation: 
`./ackermann <a> <b>`
    
This can blow up very quickly:

    ackermann(4, 0) = 13
    ackermann(5, 0) = 65533

# Why I write these
- Learning [.md](https://en.wikipedia.org/wiki/markdown) 
- Having a reason to write random ideas and a place to store them
- Maybe being helpful to someone one day
- Having access to public repo anywhere to look things up (not a real reason though) 
- Wasting my and your time