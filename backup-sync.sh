#!/usr/bin/env bash
#
# Temporary migration tool: sync database and uploads from old production
# server to new Hetzner server. Remove after migration is complete.
#
# Run manually first, then set up as a daily cron job:
#   0 2 * * * /home/appuser/vzs/backup-sync.sh >> /home/appuser/backups/vzs/sync.log 2>&1
#
# SSH prerequisites (run as appuser on Hetzner):
#   1. ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519_deployvzs
#   2. ssh-copy-id -i ~/.ssh/id_ed25519_deployvzs.pub deployvzs@production.friendlysystems.cz
#   3. Add to ~/.ssh/config:
#        Host deployvzs
#            HostName production.friendlysystems.cz
#            User deployvzs
#            IdentityFile ~/.ssh/id_ed25519_deployvzs
#            IdentitiesOnly yes
#   4. Test: ssh deployvzs "echo ok"
#
set -Eeuo pipefail

# --- Configuration ---
OLD_SSH_HOST="deployvzs"
OLD_APP_DIR="/home/deployvzs/vzs"
OLD_UPLOADS_DIR="$OLD_APP_DIR/shared/system"
OLD_DB_NAME="vzs_production"
OLD_DB_CONFIG="$OLD_APP_DIR/shared/config/database.yml"

NEW_APP_DIR="/home/appuser/vzs"
BACKUP_DIR="$HOME/backups/vzs"
COMPOSE_BIN="podman-compose"
DB_CONTAINER="vzs_db_1"

KEEP_DAILY=7
KEEP_WEEKLY=52

DATE=$(date +%Y-%m-%d)
WEEKDAY=$(date +%u)  # 1=Monday, 7=Sunday

log() { echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*"; }

# --- Setup directories ---
mkdir -p "$BACKUP_DIR/daily" "$BACKUP_DIR/weekly"

# --- 1. Read DB credentials from old server ---
log "Reading database credentials from old server"
OLD_DB_CREDS=$(ssh "$OLD_SSH_HOST" "cat $OLD_DB_CONFIG")
OLD_DB_USER=$(echo "$OLD_DB_CREDS" | grep -A 10 '^production:' | grep 'username:' | head -1 | awk '{print $2}')
OLD_DB_PASS=$(echo "$OLD_DB_CREDS" | grep -A 10 '^production:' | grep 'password:' | head -1 | awk '{print $2}')

if [ -z "$OLD_DB_USER" ] || [ -z "$OLD_DB_PASS" ]; then
    log "ERROR: Could not parse database credentials"
    exit 1
fi

# --- 2. Dump database via SSH ---
DUMP_FILE="$BACKUP_DIR/daily/backup-$DATE.sql.gz"
log "Dumping database $OLD_DB_NAME"
ssh "$OLD_SSH_HOST" "mysqldump --single-transaction --add-drop-table -u$OLD_DB_USER -p$OLD_DB_PASS $OLD_DB_NAME" \
    | gzip > "$DUMP_FILE"
log "Dump saved: $DUMP_FILE ($(du -h "$DUMP_FILE" | cut -f1))"

# --- 3. Promote to weekly backup (every Sunday) ---
if [ "$WEEKDAY" -eq 7 ]; then
    WEEK=$(date +%Y-W%V)
    WEEKLY_FILE="$BACKUP_DIR/weekly/backup-$WEEK.sql.gz"
    cp "$DUMP_FILE" "$WEEKLY_FILE"
    log "Weekly backup saved: $WEEKLY_FILE"
fi

# --- 4. Import into new server's running DB container ---
log "Importing dump into container $DB_CONTAINER"
NEW_DB_USER=$(grep '^MYSQL_USER=' "$NEW_APP_DIR/.env" | cut -d= -f2)
NEW_DB_PASS=$(grep '^MYSQL_PASSWORD=' "$NEW_APP_DIR/.env" | cut -d= -f2)
NEW_DB_NAME=$(grep '^MYSQL_DATABASE=' "$NEW_APP_DIR/.env" | cut -d= -f2)

gunzip -c "$DUMP_FILE" \
    | podman exec -i "$DB_CONTAINER" mysql -u"$NEW_DB_USER" -p"$NEW_DB_PASS" "$NEW_DB_NAME"
log "Database import complete"

# --- 5. Sync Paperclip uploads ---
log "Syncing uploads"
rsync -az --delete "$OLD_SSH_HOST:$OLD_UPLOADS_DIR/" "$NEW_APP_DIR/public/system/"
log "Upload sync complete"

# --- 6. Cleanup old backups ---
log "Cleaning up old backups"
ls -1t "$BACKUP_DIR/daily"/backup-*.sql.gz 2>/dev/null | tail -n +$((KEEP_DAILY + 1)) | xargs -r rm --
ls -1t "$BACKUP_DIR/weekly"/backup-*.sql.gz 2>/dev/null | tail -n +$((KEEP_WEEKLY + 1)) | xargs -r rm --

log "Sync complete"
