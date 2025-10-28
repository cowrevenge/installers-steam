#!/usr/bin/env bash
set -euo pipefail

: "${PUID:=1000}"
: "${PGID:=1000}"
: "${HOME:=/home/steam}"
: "${STEAMAPPDATA:=${HOME}/.local/share/Steam}"
: "${XDG_DATA_HOME:=${HOME}/.local/share}"
: "${XDG_CONFIG_HOME:=${HOME}/.config}"
: "${XDG_CACHE_HOME:=${HOME}/.cache}"

mkdir -p "${STEAMAPPDATA}" "${XDG_DATA_HOME}" "${XDG_CONFIG_HOME}" "${XDG_CACHE_HOME}" /mnt/server
chown -R "${PUID}:${PGID}" /home/steam /mnt/server || true

cat > /mnt/server/installer-env.txt <<EOF
PUID=${PUID}
PGID=${PGID}
HOME=${HOME}
STEAMAPPDATA=${STEAMAPPDATA}
XDG_DATA_HOME=${XDG_DATA_HOME}
XDG_CONFIG_HOME=${XDG_CONFIG_HOME}
XDG_CACHE_HOME=${XDG_CACHE_HOME}
EOF

echo "Installer OK: HOME=${HOME} STEAMAPPDATA=${STEAMAPPDATA}"
