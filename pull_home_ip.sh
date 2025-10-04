#!/bin/bash
# /usr/local/bin/pull_home_ip.sh
# Resolve jayburd.duckdns.org via public resolvers and export HOME_WAN_IP
# Logs to ~/.local/share/duckdns/pull_ip.log

set -euo pipefail

HOST="jayburd.duckdns.org"
ENVFILE="$HOME/.home_ip.env"
LOGDIR="$HOME/.local/share/duckdns"
LOGFILE="$LOGDIR/pull_ip.log"
TIMESTAMP="$(date '+%Y-%m-%d %H:%M:%S')"

mkdir -p "$LOGDIR"

# Query multiple public resolvers; take the first valid IP
IP=""
for ns in 1.1.1.1 8.8.8.8 9.9.9.9; do
  IP="$(dig +short "$HOST" @"$ns" | tail -n1 || true)"
  [[ -n "$IP" ]] && break
done

# If all resolvers fail, fall back to system default
if [[ -z "$IP" ]]; then
  if command -v host >/dev/null 2>&1; then
    IP="$(host "$HOST" 2>/dev/null | awk '/has address/ {print $4}' | tail -n1 || true)"
  elif command -v getent >/dev/null 2>&1; then
    IP="$(getent hosts "$HOST" | awk '{print $1}' | tail -n1 || true)"
  else
    IP="$(ping -c1 "$HOST" 2>/dev/null | awk -F'[()]' '/PING/ {print $2}' || true)"
  fi
fi

# Write IP to env file and log
if [[ -n "${IP}" ]]; then
  TMPFILE="$(mktemp "${ENVFILE}.XXXX")"
  printf 'export HOME_WAN_IP=%s\n' "$IP" > "$TMPFILE"
  mv "$TMPFILE" "$ENVFILE"
  printf '[%s] Updated HOME_WAN_IP=%s\n' "$TIMESTAMP" "$IP" >> "$LOGFILE"
else
  printf '[%s] Failed to resolve %s via public DNS\n' "$TIMESTAMP" "$HOST" >> "$LOGFILE"
fi
