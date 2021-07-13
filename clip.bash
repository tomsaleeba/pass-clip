#!/usr/bin/env bash

######################## Original License ########################
# pass clip - Password Store Extension (https://www.passwordstore.org/)
# Copyright (C) 2019 Pierre PENNINCKX <ibizapeanut@gmail.com>.
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
######################## Original License ########################

# Modifications carried out by ArcherN9
# - Removed Rofi
# - The program no longer attempts to generate a password if it does not already exist
# - The original program in its current shape and form was not OSX compliant.
# - Replaced Find with fd


PASSWORD_STORE_DIR="${PASSWORD_STORE_DIR:-$HOME/.password-store}"

cmd_clip_usage() {
    cat <<-_EOF
    Usage:
    $PROGRAM clip [options]
        Provide an interactive solution to copy passwords to the
        clipboard. It will show all pass-names in fzf, waits for the user
	to select one then copies it to the clipboard.

_EOF
    exit 0
}

cmd_clip_short_usage() {
    echo "Usage: $PROGRAM $COMMAND [--help,-h]"
}

command_exists() {
    command -v "$1" >/dev/null 2>&1 || exit 1
}

cmd_clip() {
    local opts fzf=0
    local err=$?
    # Parse arguments
    if command_exists fzf; then
        fzf=1
    fi

    [[ $err -ne 0 ]] && die "$(cmd_clip_short_usage)"

    # Figure out if we use fzf
    local prompt='Search Query :: '
    local fzf_cmd="fzf --print-query --prompt=\"$prompt\" -i --no-mouse"

    if [ -n "$term" ]; then
      fzf_cmd="$fzf_cmd -q\"$term\""
    fi

    fzf_cmd="$fzf_cmd | tail -n1"

    if [[ $fzf = 1 ]]; then
        command_exists fzf || die "Could not find fzf in \$PATH"
        menu="$fzf_cmd"
    fi

    cd "$PASSWORD_STORE_DIR" || die "Could not locate password store directory. Please ensure \$PASSWORD_STORE_DIR is setup."

    # Select a passfile
    passfile=$(
        cd $PASSWORD_STORE_DIR  \
        && fd --type f          \
        | sed -e 's/.gpg$//'    \
        | sort                  \
        | eval "$menu" )

    # If no pass file was selected by the user, exit the program with an error
    if [ -z "$passfile" ]; then
        die 'No passfile selected.'
    fi

    if ! ls "$passfile.gpg" > /dev/null 2>&1; then
      die "Passfile $passfile not found"
    fi

    # clean up any zombie gpg prompt processes
    pkill -f 'gpg.*password-store' || true

    re='\([A-Za-z0-9_.-]*\): \(.*\)'
    passKey='pass'

    availableKeys=$(cmd_show "$passfile" | tail +3 | sed "s/$re/\1/")
    # select a key to copy
    keySel=$(echo -e "$passKey\n$availableKeys" | fzf)

    if [ -z "$keySel" ]; then
      die 'No key selected.'
    fi

    if [ $keySel = $passKey ]; then
      cmd_show --clip "$passfile"
    else
      val=$(cmd_show "$passfile" | grep "$keySel: " | head -n 1 | sed "s/$re/\2/")
      if [ -z "$val" ]; then
        die 'No val produced.'
      fi
      echo "[INFO] copied $keySel to clipboard"
      echo -n "$val"| pbcopy
    fi
}

[[ "$1" == "help" || "$1" == "--help" || "$1" == "-h" ]] && cmd_clip_usage

cmd_clip "$@"
