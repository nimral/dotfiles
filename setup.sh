#!/bin/bash

for a in .bash_profile .bashrc .gitconfig .vimrc .xinitrc .config/openbox/rc.xml .config/openbox/autostart .pdbrc ; do
    filename="$HOME/$a"
    if [ -e "$filename" ] ; then
        if ! cmp "$a" "$filename" >/dev/null 2>&1 ; then
            backup="${filename}_`date +'%Y-%m-%d_%H-%M-%S'`.backup"
            echo "$filename already exists (and differs), backing up as $backup"
            mv "$filename" "$backup"
        else
            rm "$filename"
        fi
    fi
    if [ -L "$filename" ] ; then
        if ! [ "`pwd -P`/$a" = "`readlink -f $filename`" ] ; then
            echo -n "$filename is a link to "
            readlink -f "$filename"
        fi
        continue
    fi
    ln -s "`pwd -P`/$a" "$filename"
done


mkdir -p "$HOME/bin"
cp -i bin/* "$HOME/bin/"
