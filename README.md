# pass clip 0.3 [![build status][build-img]][build-url]

A [Password Store (Pass)](https://www.passwordstore.org/) extension that lets you leverage the power of [FZF](https://github.com/junegunn/fzf) to fuzzy find stored passwords and snap them to the clipboard.

## Usage

```\w
    Usage:
    $PROGRAM clip [options]
        Provide an interactive solution to copy passwords to the
        clipboard. It will show all pass-names in fzf, waits for the user 
	to select one then copies it to the clipboard.
```
Please refer examples on the official Pass Clip Repository. The interface has been kept consistent.

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
