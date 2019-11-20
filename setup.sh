#!/bin/bash

# create links to dotfiles in this repository
for a in .bash_profile .bashrc .gitconfig .vimrc .xinitrc .xsessionrc .config/openbox/rc.xml .config/openbox/rc.xml.jinja2 .config/openbox/autostart .pdbrc ; do
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
    dir=`echo "$a" | sed -r 's/[^/]*$//'`
    if ! [ -z "$dir" ] ; then
        mkdir -p $HOME/"$dir"
    fi
    ln -s "`pwd -P`/$a" "$filename"
done

# set up Vundle
if ! [ -e $HOME/.vim/bundle/Vundle.vim ] ; then
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi



mkdir -p "$HOME/bin"
cp -i bin/* "$HOME/bin/"
