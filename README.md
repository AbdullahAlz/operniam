# opeRniaM
### Overview
### This repository consists of many independent small programs. Nothing here is of use unless you know what you are looking for

If any future program in this repository becomes useful, feel free to use and improve it. However I recommend reading the code first as I cannot guarantee perfection.

The following is a chronological list of the programs in this repository with a brief description.


## `recursiveExtract.sh`

This is a forensic tool that, in a read-only state,  recursively extracts files from a partition image. It uses sleuthkit tools to extract files and creates directories based on the file paths in the image.

May have missed some combination of flags that does this automatically but now there is a script.


## `updtdsc.sh`

Automate Discord updates on Debian.

This was my first bash script, ever.

Using [Discord](https://discord.com/) [isnt a great thing](https://cadence.moe/blog/2020-06-06-why-you-shouldnt-trust-discord). On Debian, whenever a new Discord update comes out, you have to download a .deb file and install it.

This script checks for an existing Discord version, checks the up-to-date stable version and, if necessary, downloads and updates discord

Currently this can only handle `.deb` files.


## `perfectNumber.py`
For some given number of iterations, all even perfect numbers are calculated, using the same old boring method.
> For a prime number `p`, if $$(2^p-1)$$ is prime, then $$2^{p-1}(2^p-1)$$ is perfect

## `remover.c` (removed)

This program finds the **last** occurrence of a given string in every line of a text file and removes the contents of that line up to, and including, that String.

Initially used with `/` to obtain the base name of a file. Later, I realized that I could use `sed` or just `basename <path>`


## `ackermann.c`
This is a basic C implementation of the deeply recursing 
[ackermann function](https://en.wikipedia.org/wiki/Ackermann_function)

Usage after Compilation: 
`./ackermann <a> <b>`
    
This can blow up very quickly:

    ackermann(4, 0) = 13
    ackermann(5, 0) = 65533

# Why I write these
- Learning
- Having a reason to write random ideas and a place to store them
- Maybe being helpful to someone one day
- Using this public repo to get some of the more useful scripts on a new or remote machine 
- Wasting my and your time
