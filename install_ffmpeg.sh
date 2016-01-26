#!/bin/bash
wget http://ffmpeg.gusari.org/static/32bit/ffmpeg.static.32bit.latest.tar.gz
# wget -qO- https://raw.githubusercontent.com/omgbox/scripts/master/install_ffmpeg.sh | bash
sleep 1

tar xvf ffmpeg.static.32bit.latest.tar.gz

sleep 1

cp ffmpeg /usr/bin/ffmpeg

sleep 1

rm ffmpeg

sleep 1

rm ffprobe

sleep 1

rm *.gz
