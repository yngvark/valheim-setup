if [[ -z $1 ]]; then
    ME=$(basename $0)
    echo "USAGE: $ME <directory of Valheim Backups>"
    echo "EXAMPLE: $ME ~/valheim-server/config/backups"
    exit 1
fi


CURRENT_DIR=`pwd`
VALHEIM_BACKUP_DIR=$1
LOGFILE=/tmp/upload-valheim-backup.log

if [[ $(crontab -l | egrep -v "^(#|$)" | grep -q 'valheim-backup'; echo $?) == 1 ]]
then
    set -f
    printf "$(crontab -l ; echo "30 * * * * $CURRENT_DIR/upload-valheim-backup.sh") \n" | crontab -
    set +f
fi

cat <<EOF > upload-valheim-backup.sh
echo Running backup at \$(date) >> $LOGFILE

rclone sync -v \
  $VALHEIM_BACKUP_DIR \
  jotta:/valheim-server/config/backups \
  --jottacloud-hard-delete \
  1>>$LOGFILE \
  2>&1
EOF

chmod +x upload-valheim-backup.sh

echo Backup will be running every hour at xx:30. See for yourself with: crontab -e
echo
echo Run manually by running:
echo ./upload-valheim-backup.sh
echo
echo Log:
echo cat $LOGFILE
echo
