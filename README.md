# pass clip 0.3

A [Password Store (Pass)](https://www.passwordstore.org/) extension that lets you leverage the power of [FZF](https://github.com/junegunn/fzf) to fuzzy find stored passwords and snap them to the clipboard.

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

## Installation

The following installation guide is generic and a personal preference. Please refer Pass Clip and Pass extension guide for more information on how to handle extensions.

```sh
$ cd /opt 
$ git clone git@github.com:ArcherN9/pass-clip.git
$ cd ~/.password-store && mkdir .extensions && cd .extensions
$ ln -s /opt/pass-clip/clip.bash . # I Prefer this way so that I can keep the git repository separate and reference it as an active extension at the same time
```

### Requirements

* `pass 1.7.0` or greater.
* You need to enable user extensions with `PASSWORD_STORE_ENABLE_EXTENSIONS=true`. 


## Acknowledgments

I've recently started using FZF and have been looking at ways to include it in all aspects of my terminal interactions. It makes me more efficient. I'm glad to have stumbled on the original `Pass Clip` program to make it my own. 
