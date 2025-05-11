# opeRniaM
### Overview
> This repository consists of many independent small programs. Nothing here is of use unless you know what you are looking for

If any future program in this repository becomes useful, feel free to use and improve it. However I recommend reading the code first as I cannot guarantee perfection.

The following is a chronological list of the programs in this repository with a brief description.

## `full-setup.sh`

### For setting up Debian or Ubuntu

This is a script meant automate setting up a machine with newly installed Debian. The goal is to do as much as it can automatically.

### Warning
I don't recommend using this script on your machine since it currently assumes many parameters that are specific to my devices (Nvidia GPU). It could also install software that you don't want but I do. This script is currently entirely meant for me to access publicly to set up any new Debian-based device.

## `updtdsc.sh`



This was my first bash script. It automates Discord updates on Debian.

Being a [Discord](https://discord.com/) user [(bad)](https://cadence.moe/blog/2020-06-06-why-you-shouldnt-trust-discord), I had many issues after moving to Debian. Whenever a new Discord update comes out, you have to download a .deb file and install it. So instead of doing that manually every time, I wrote this script to replace the discord launcher itself.

It checks for an existing Discord version, checks the up-to-date stable version and, if necessary, downloads and updates discord and in all cases launches the application.

Launching this script is meant to be equivalent to running Discord on Windows. `update.exe` checks for an update before running discord itself on Windows. As always, read the script yourself before using it. If you do use it, I recommend replacing discord with it. This is done by putting this script in `.local/share/applications` and giving it the right to run.

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
- Learning [.md](https://en.wikipedia.org/wiki/markdown) 
- Having a reason to write random ideas and a place to store them
- Maybe being helpful to someone one day
- Using this public repo to get some of the more useful scripts on a new or remote machine 
- Wasting my and your time
