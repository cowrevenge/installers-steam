FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    bash ca-certificates curl unzip xz-utils tar jq coreutils tini \
 && rm -rf /var/lib/apt/lists/*

ENV PUID=1000 \
    PGID=1000 \
    HOME=/home/steam \
    STEAMAPPDATA=/home/steam/.local/share/Steam \
    XDG_DATA_HOME=/home/steam/.local/share \
    XDG_CONFIG_HOME=/home/steam/.config \
    XDG_CACHE_HOME=/home/steam/.cache

RUN groupadd -g ${PGID} steam \
 && useradd -m -u ${PUID} -g ${PGID} steam \
 && mkdir -p /mnt/server "$STEAMAPPDATA" "$XDG_DATA_HOME" "$XDG_CONFIG_HOME" "$XDG_CACHE_HOME" \
 && chown -R ${PUID}:${PGID} /home/steam /mnt/server

ENTRYPOINT ["/usr/bin/tini","--","/bin/bash"]
