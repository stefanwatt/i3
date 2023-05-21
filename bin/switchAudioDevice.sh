#!/usr/bin/env bash

currentSinkId=$(\
  ponymix defaults |\
  sed -e '/^source/,+2d'\
  -e '/^sink/{n;N;d}' |\
  awk '{print $2}' |\
  sed 's/://'\
)

headset="sink [0-9]: alsa_output.usb-Logitech_PRO_X_Wireless_Gaming_Headset-00.analog-stereo"
speaker="sink [0-9]: bluez_sink.08_EB_ED_CD_CB_02.a2dp_sink"
newSinkId=$(\
  ponymix -t sink list |\
  sed -E -e "/$headset|$speaker/,+2!d"\
  -e '/Avg/d' \
  -e '/^\s/d' \
  -e 's/sink ([0-9]):/\1/' |\
  sed "/^$currentSinkId/d" |\
  awk '{print $1}'
)

ponymix set-default -d "$newSinkId"

inputIds=$(\
  ponymix list -t sink-input |\
  sed '/^sink/!d' |\
  awk '{print $2}' |\
  sed 's/://'\
)

IFS=$'\n'
set -f 
for i in $inputIds; do
  ponymix -t sink-input -d "$i" move "$newSinkId"
done
