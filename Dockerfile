FROM jrottenberg/ffmpeg:6.1-ubuntu

WORKDIR /app
COPY stream.sh /app/stream.sh

RUN chmod +x /app/stream.sh

CMD ["/app/stream.sh"]
