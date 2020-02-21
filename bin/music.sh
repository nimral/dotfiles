#! /bin/bash
mocp_running () {
    ps aux | grep 'mocp' | grep -v grep >/dev/null
}

spotify_running () {
    ps aux | grep '/usr/share/spotify' | grep -v grep >/dev/null
}

toggle_pause () {
    if spotify_running ; then
        sp play # toggles
    else
        mocp -G
    fi
}

next () {
    if spotify_running ; then
        sp next
    else
        mocp -f && sleep 0.25 && notify-send -t 2000 "$(mocp --info | grep -E "^Title")"
    fi
}

previous () {
    if spotify_running ; then
        sp prev
    else
        mocp -r && sleep 0.25 && notify-send -t 2000 "$(mocp --info | grep -E "^Title")"
    fi
}


info () {
    if spotify_running ; then
        wget "`sp art`" -q -O /tmp/spotify_album_icon
        album=`sp current | grep '^Album ' | sed -r 's/Album +//'`
        artist=`sp current | grep '^Artist ' | sed -r 's/Artist +//'`
        title=`sp current | grep '^Title ' | sed -r 's/Title +//'`
        notify-send "$artist - $title ($album)" -i "/tmp/spotify_album_icon"
    else
        # show position
        tt=`mocp -Q '%tt'`
        minuty=`echo $tt | cut -d ':' -f 1`
        sekundy=`echo $tt | cut -d ':' -f 2`
        tt=`expr 60 \* $minuty + $sekundy`
        tl=`mocp -Q '%tl'`
        minuty=`echo $tl | cut -d ':' -f 1`
        sekundy=`echo $tl | cut -d ':' -f 2`
        tl=`expr 60 \* $minuty + $sekundy`
        celkova_delka=30
        ubehle=`expr $celkova_delka - \( $celkova_delka \* $tl / $tt \)`

        vypis=""
        for i in `seq $ubehle` ; do
            vypis="$vypis#"
        done
        for i in $(seq `expr $celkova_delka - $ubehle`) ; do
            vypis="$vypis~"
        done

        ikona=$(find "`mocp --info | grep File | sed -r 's/File: (.*)\/.*/\1/'`" -name '*jpg' -or -name '*png' -or -name '*bmp' | grep -v back | head -1)
        notify-send -t 5000 "$(mocp --info | grep -E "^Title")

$vypis" -i "$ikona"
    fi

}

if ! mocp_running ; then
    mocp -S
fi

if [ "$#" != "0" ]; then
    ukol="$1"
    if [ "$ukol" = "-p" ]; then
        toggle_pause
    elif [ $ukol = "-r" ]; then
        previous
    elif [ $ukol = "-f" ]; then
        next
    elif [ $ukol = "-i" ]; then
        info
    elif [ $ukol = "-vp" ]; then
        mocp -v +2
    elif [ $ukol = "-vm" ]; then
        mocp -v -2
    fi
fi

