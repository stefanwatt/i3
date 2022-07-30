#!/bin/env bash

bash ~/.config/i3/bin/xrandr.sh &

# polybar
$HOME/.config/i3/bin/launchbar.sh &

nitrogen --set-zoom-fill ~/.config/i3/wallpaper.png &

# Fix cursor
xsetroot -cursor_name left_ptr &

# kill if already running
killall -9 picom xfce4-power-manager dunst sxhkd &

brave-browser --app="https://teams.microsoft.com" &
# start hotkey daemon
sxhkd &

# Launch notification daemon
dunst -config $HOME/.config/i3/dunstrc &

# start compositor and power manager
xfce4-power-manager &

autokey-gtk &

while pgrep -u $UID -x picom >/dev/null; do sleep 1; done
picom --config $HOME/.config/i3/picom.conf &

# start polkit
# if [[ ! `pidof xfce-polkit` ]]; then
#     /usr/lib/xfce-polkit/xfce-polkit &
# fi

# start udiskie
udiskie &

bash ~/Scripts/zscaler.sh &

i3-msg '[instance="teams.microsoft.com"] floating disable' &
i3-msg '[instance="teams.microsoft.com"] move to workspace 1' &

remmina &

flameshot &
