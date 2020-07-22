FROM bash:5

COPY ./entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
