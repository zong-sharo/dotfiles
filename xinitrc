#!/bin/bash
if [[ ! `pgrep urxvtd -u $USER` ]]
then
	urxvtd &
fi

xmonad & wmpid=$!

xsetroot -solid 'black'
#us, ru_winkeys, switch by caps, scroll led
setxkbmap 'us,ru(winkeys)'
setxkbmap -option
setxkbmap -option 'grp_led:caps,grp:caps_toggle'

conky &> /dev/null
if [[ $(hostname) != "vostro" ]]
then
    XRDB_FLAGS="-DUSE_CMU_TYPEWRITER"
    xmodmap .Xmodmap
fi

xrdb $XRDB_FLAGS .Xresources

wait $wmpid
