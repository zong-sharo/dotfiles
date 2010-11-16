#!/bin/bash
# = Urxvtd =
[[ -z `pgrep urxvtd -u $USER` ]] && urxvtd &

# = Input =
setxkbmap -model evdev -layout 'us,ru(winkeys)'

# = Layout acyclic switch =
xmodmap .Xmodmap

# = Host-specific font and keyboard fixes =
if [[ $(hostname) == "silver" ]]
then
    XRDB_FLAGS="-DUSE_CMU_TYPEWRITER"
    xmodmap .Xmodmap.apple_keyboard.A1243.fix
fi

# = Urxvt settings  =
xrdb -merge $XRDB_FLAGS .Xresources

# = Xmonad =
xmonad & wmpid=$!

# = Background =
if (which xcompmgr &> /dev/null)
then
    xcompmgr &
    which hsetroot &> /dev/null && hsetroot -solid '#000000'
else
    xsetroot -solid 'black'
fi

which conky &> /dev/null && conky &> /dev/null &

which unclutter &> /dev/null && unclutter -idle 5 -root &

wait $wmpid
