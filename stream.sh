#!/usr/bin/env bash
set -euo pipefail

# Hardcoded as requested.
STREAM_KEY="y1su-d7dq-59up-jpqr-2t8m"

RESOLUTION="${RESOLUTION:-1920x1080}"
FPS="${FPS:-30}"
VIDEO_BITRATE_K="${VIDEO_BITRATE_K:-4500}"
AUDIO_BITRATE_K="${AUDIO_BITRATE_K:-128}"

PRIMARY_URL="rtmp://a.rtmp.youtube.com/live2/${STREAM_KEY}"
BACKUP_URL="rtmp://b.rtmp.youtube.com/live2?backup=1/${STREAM_KEY}"

echo "Starting continuous YouTube red-screen stream..."
echo "Resolution: ${RESOLUTION}, FPS: ${FPS}, Video: ${VIDEO_BITRATE_K}k, Audio: ${AUDIO_BITRATE_K}k"

auto_bufsize=$(( VIDEO_BITRATE_K * 2 ))
auto_gop=$(( FPS * 2 ))

exec ffmpeg -hide_banner -loglevel info -re \
  -f lavfi -i "color=c=red:s=${RESOLUTION}:r=${FPS}" \
  -f lavfi -i "anullsrc=channel_layout=stereo:sample_rate=44100" \
  -c:v libx264 -pix_fmt yuv420p -preset veryfast -tune zerolatency \
  -b:v "${VIDEO_BITRATE_K}k" -maxrate "${VIDEO_BITRATE_K}k" -bufsize "${auto_bufsize}k" -g "${auto_gop}" \
  -c:a aac -b:a "${AUDIO_BITRATE_K}k" -ar 44100 -ac 2 \
  -f tee "[f=flv:onfail=ignore]${PRIMARY_URL}|[f=flv:onfail=ignore]${BACKUP_URL}"
