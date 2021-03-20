: "${VALHEIM_SERVER_PASS:?Needs to be non-empty.}"
: "${VALHEIM_SERVER_NAME:?Needs to be non-empty.}"
: "${VALHEIM_WORLD_NAME:?Needs to be non-empty.}"

# Backup cron explanation:
# Every hour at minute 0. https://crontab.guru/#0_*_*_*_*

# IMPORTANT, if importing a save game! WORLD_NAME must match your world name!
# See similar comment, ctrl+f "Do not forget to" at
# https://github.com/lloesche/valheim-server-docker#manual-backup

docker run -d \
    --name valheim-server \
    --cap-add=sys_nice \
    --stop-timeout 120 \
    -p 2456-2457:2456-2457/udp \
    -p 80:80 \
    -v $HOME/valheim-server/config:/config \
    -v $HOME/valheim-server/data:/opt/valheim \
    -e SERVER_NAME=$VALHEIM_SERVER_NAME \
    -e WORLD_NAME=$VALHEIM_WORLD_NAME \
    -e SERVER_PASS=$VALHEIM_SERVER_PASS \
    -e TZ="Europe/Stockholm" \
    -e BACKUPS_CRON="SE" \
    -e BACKUPS_MAX_AGE="10" \
    -e BACKUPS_CRON="0 * * * *" \
    -e STATUS_HTTP="true" \
    -e SERVER_PUBLIC="true" \
    lloesche/valheim-server

