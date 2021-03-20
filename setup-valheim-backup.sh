if [[ -z $1 ]]; then
    ME=$(basename $0)
    echo "USAGE: $ME <directory of Valheim Backups>"
    echo "EXAMPLE: $ME /home/myself/valheim-server/config/backups"
    exit 1
fi


CURRENT_DIR=`pwd`
VALHEIM_BACKUP_DIR=$1

if [[ $(crontab -l | egrep -v "^(#|$)" | grep -q 'valheim-backup'; echo $?) == 1 ]]
then
    set -f
    printf "$(crontab -l ; echo "30 * * * * $CURRENT_DIR/upload-valheim-backup.sh") \n" | crontab -
    set +f
fi

cat <<EOF > upload-valheim-backup.sh
echo Running backup at \$(date) >> /var/log/upload-valheim-backup.log
rclone sync $VALHEIM_BACKUP_DIR jotta:/valheim-server/config/backups
EOF
