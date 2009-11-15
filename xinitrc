#!/bin/bash
if [[ ! `pgrep urxvtd -u $USER` ]]
then
	urxvtd &
fi

xmonad & wmpid=$!

if (which xcompmgr &> /dev/null)
then
    xcompmgr &
    if (which hsetroot &> /dev/null)
    then hsetroot -solid 'black'
    fi
else
    xsetroot -solid 'black'
fi
#us, ru_winkeys, switch by caps, scroll led
setxkbmap -symbols 'pc+us+ru(winkeys):2+group(caps_toggle)' -compat 'complete+ledscroll(group_lock)'

conky &> /dev/null
if [[ $(hostname) != "vostro" ]]
then
    XRDB_FLAGS="-DUSE_CMU_TYPEWRITER"
    xmodmap .Xmodmap
fi

xrdb $XRDB_FLAGS .Xresources

wait $wmpid
