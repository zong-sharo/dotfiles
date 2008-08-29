#!/bin/bash
xmonad & wmpid=$!

xsetroot -solid 'black'
#us, ru_winkeys, switch by caps, scroll led
setxkbmap -symbols 'pc+us+ru(winkeys):2+group(caps_toggle)' -compat 'complete+ledscroll(group_lock)'

conky
if [[ $(hostname) == "ep" ]]
then
    XRDB_FLAGS="-DCMUTT"
fi

xrdb $XRDB_FLAGS .Xresources

if [[ ! `pgrep urxvtd -u kleptos` ]]
then
	urxvtd &
fi

wait $wmpid
