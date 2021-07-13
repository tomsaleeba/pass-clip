# pass clip 0.3-tomsaleeba

A [Password Store (Pass)](https://www.passwordstore.org/) extension that lets
you leverage the power of [FZF](https://github.com/junegunn/fzf) to fuzzy find
stored passwords (and other values in the safe) and snap them to the clipboard.

## How to use

```sh
$ pass clip

# The output should be something similar

> Verge/TestAccount1
> NYT/TestAccount2
> PriceMongo/TestAccount3
> Testing Website/silly account 4
> Office/my official account
> This demo isn\'t going well/ is it account
6/6
Search Query::  # Enter the query here to let FZF do what it does best. Magic.
```

Then, we'll parse the selected entry to let you select which key to copy:
```sh
email
url
user
pass
4/3
:
```

## Installation

The following installation guide is generic and a personal preference. Please
refer Pass Clip and Pass extension guide for more information on how to handle
extensions.

```sh
$ cd ~/.password-store && mkdir -p .extensions && cd .extensions
$ git submodule add git@github.com:tomsaleeba/pass-clip.git
$ ln -s pass-clip/clip.bash
$ echo "alias pc='PASSWORD_STORE_ENABLE_EXTENSIONS=true pass clip'" >> ~/.zshrc
```

This extension expects that your password files have the following format:
```
<password>
---
<key1>: <value>
<key2>: <value>
<keyN>: <value>
...
```

Check the script for the regex we use to match the key, but it's roughly what
you'd expect: letters, numbers, hyphen, underscore and dot.

### Requirements

* `pass 1.7.0` or greater.
* You need to enable user extensions with `PASSWORD_STORE_ENABLE_EXTENSIONS=true`.


## Acknowledgments

I've recently started using FZF and have been looking at ways to include it in
all aspects of my terminal interactions. It makes me more efficient. I'm glad to
have stumbled on the original `Pass Clip` program to make it my own.

[ArcherN9/pass-clip](https://github.com/ArcherN9/pass-clip) for making something
that works on MacOS, and introducing me to `fd`.
