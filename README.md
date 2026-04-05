# YouTube Red Screen Stream (Render + Docker + FFmpeg)

This repository is now packaged to run a **continuous red-screen YouTube stream** as a containerized worker.

- FFmpeg is included via Docker image (`jrottenberg/ffmpeg:6.1-ubuntu`)
- No runtime dependency is required on the host besides Docker/Render
- Stream key is **hardcoded** in `stream.sh` (as requested)

## Files

- `stream.sh` – starts infinite FFmpeg red-screen stream to YouTube primary + backup RTMP
- `Dockerfile` – builds the streaming container with FFmpeg
- `render.yaml` – Render Blueprint definition for a Docker worker service

## Hardcoded stream key

The current hardcoded key is:

`y1su-d7dq-59up-jpqr-2t8m`

If you need to change it, edit `STREAM_KEY` in `stream.sh`.

## Deploy on Render

1. Push this repository to GitHub.
2. In Render, create a new **Blueprint** deployment and select this repo.
3. Render reads `render.yaml` and creates the `yt-red-stream` worker service.
4. Deploy.

Once deployed, the worker starts FFmpeg and streams continuously.

## Optional runtime tuning (env vars)

You can configure the stream without code changes using env vars:

- `RESOLUTION` (default: `1920x1080`)
- `FPS` (default: `30`)
- `VIDEO_BITRATE_K` (default: `4500`)
- `AUDIO_BITRATE_K` (default: `128`)

## Notes

- Hardcoding keys in repo is insecure; use secrets for production.
- If Render free worker limits/suspension apply to your account, continuous uptime may be affected.
