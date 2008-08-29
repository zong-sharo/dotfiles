#!/bin/bash
xmonad & wmpid=$!

xsetroot -solid 'black'
conky
xrdb .Xresources
#xmodmap .Xmodmap

if [[ ! `pgrep urxvtd -u kleptos` ]]
then
	urxvtd &
fi

wait $wmpid
