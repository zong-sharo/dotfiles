#!/bin/bash
xmonad & wmpid=$!

xsetroot -solid 'black'
#us, ru_winkeys, switch by caps, scroll led
setxkbmap 'us,ru(winkeys)'
setxkbmap -option
setxkbmap -option 'grp_led:caps,grp:caps_toggle'

setxkbmap -symbols 'pc+us+ru(winkeys):2+group(caps_toggle)' -compat 'complete+ledscroll(group_lock)'

conky &> /dev/null
if [[ $(hostname) != "vostro" ]]
then
    XRDB_FLAGS="-DUSE_CMU_TYPEWRITER"
    xmodmap .Xmodmap
fi

xrdb $XRDB_FLAGS .Xresources

if [[ ! `pgrep urxvtd -u $USER` ]]
then
	urxvtd &
fi

wait $wmpid
