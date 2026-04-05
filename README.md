# YouTube Red Screen Stream Tool

This repository contains a GitHub Pages web tool that generates an `ffmpeg` command to stream a **continuous red screen** to YouTube using:

- Primary RTMP: `rtmp://a.rtmp.youtube.com/live2`
- Backup RTMP: `rtmp://b.rtmp.youtube.com/live2?backup=1`

## What this tool does

The page lets you enter your YouTube stream key and stream settings, then generates a ready-to-run command that:

By default, the generator is prefilled with stream key `y1su-d7dq-59up-jpqr-2t8m`; replace it if needed before streaming.

- Creates a red video feed forever with FFmpeg's `lavfi` color source.
- Adds silent stereo audio (required by many platforms).
- Pushes to both primary and backup YouTube ingest endpoints with `tee`.

## Deploy on GitHub Pages

1. Push this repository to GitHub.
2. Ensure your default branch is `main` (or update `.github/workflows/deploy-pages.yml`).
3. In your repo settings, open **Pages** and set source to **GitHub Actions**.
4. Push to `main`.
5. Wait for the `Deploy static site to GitHub Pages` workflow to finish.

Your site will be available at:

`https://<your-github-username>.github.io/<repo-name>/`

## Streaming

After opening the site:

1. Enter your YouTube stream key.
2. Click **Generate Command**.
3. Run the output command on a machine/server with FFmpeg installed.

> GitHub Pages hosts only the generator UI. The actual RTMP streaming process must run outside GitHub Pages.
