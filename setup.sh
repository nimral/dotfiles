#!/bin/bash

for a in .bash_profile .bashrc .gitconfig .vimrc .xinitrc .config/openbox/rc.xml .config/openbox/autostart .pdbrc ; do
    filename=$HOME/$a
    if [ -e $filename ] ; then
        if ! [ -L $filename ] ; then
            backup="${filename}_`date +'%Y-%m-%d_%H-%M-%S'`.backup"
            echo "$filename already exists, backing up as $backup"
            mv $filename $backup
        else
            # it is a symlink, hopefully to the right location
            # => we do nothing
            continue
        fi
        echo ln -s $a $filename
    fi
done


mkdir -p $HOME/bin
cp bin/* $HOME/bin/
