FROM jrottenberg/ffmpeg:6.1-ubuntu

WORKDIR /app
COPY stream.sh /app/stream.sh

RUN chmod +x /app/stream.sh

# The base image sets ENTRYPOINT to ffmpeg. Override it so Render starts our script.
ENTRYPOINT ["/app/stream.sh"]
