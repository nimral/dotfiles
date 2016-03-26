#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# exec gnome-session
# exec startkde
#exec startxfce4
# ...or the Window Manager of your choice
#exec twm
#exec xterm
#exec entraced

# The following variable defines the session which is started if the user doesn't explicitly select a session
# Source: http://svn.berlios.de/svnroot/repos/slim/trunk/xinitrc.sample

DEFAULT_SESSION=openbox

setxkbmap cz
setxkbmap -option compose:caps
xmodmap -e "keycode 94 = Shift_L"
xset dpms 120 130 300
xset -b #vypne beep
#(sleep 1 ; xfce4-panel) &
#(sleep 1 ; orage) &
~/.fehbg
#wicd-gtk &
synclient MaxTapTime=0


#exec startxfce4

case $1 in
kde)
	exec startkde
	;;
xfce4)
	exec startxfce4
	;;
xmonad)
	xsetroot -cursor_name left_ptr
	exec xmonad
	;;
icewm)
	icewmbg &
	icewmtray &
	exec icewm
	;;
wmaker)
	exec wmaker
	;;
blackbox)
	exec blackbox
	;;
enlightenment)
	exec enlightenment_start
	;;
openbox)
    export DE=xfce
	exec openbox-session
	;;
*)
    export DE=xfce
	exec openbox-session
	;;
esac

