: "${VALHEIM_SERVER_PASS:?Needs to be non-empty.}"

# Backup cron explanation:
# Every hour at minute 0. https://crontab.guru/#0_*_*_*_*



docker run -d \
    --name valheim-server \
    --cap-add=sys_nice \
    --stop-timeout 120 \
    -p 2456-2457:2456-2457/udp \
    -p 80:80 \
    -v $HOME/valheim-server/config:/config \
    -v $HOME/valheim-server/data:/opt/valheim \
    -e SERVER_NAME="YKServer" \
    -e WORLD_NAME="Gurgheim" \
    -e SERVER_PASS=$VALHEIM_SERVER_PASS \
    -e SERVER_PUBLIC="false" \
    -e TZ="Europe/Stockholm" \
    -e BACKUPS_CRON="SE" \
    -e BACKUPS_MAX_AGE="10" \
    -e BACKUPS_CRON="0 * * * *" \
    -e STATUS_HTTP="true" \
    lloesche/valheim-server


#    -e SERVER_PUBLIC="true" \
