#!/usr/bin/env bash
#
# Pre-flight checklist for backup-sync.sh
# Run on deployvzs (old production) to verify everything backup-sync expects.
#
# Usage: ssh deployvzs 'bash -s' < check-deployvzs.sh
#
set -euo pipefail

PASS=0
FAIL=0
WARN=0

pass() { echo "  [OK]   $1"; PASS=$((PASS + 1)); }
fail() { echo "  [FAIL] $1"; FAIL=$((FAIL + 1)); }
warn() { echo "  [WARN] $1"; WARN=$((WARN + 1)); }

APP_DIR="/home/deployvzs/vzs"
DB_CONFIG="$APP_DIR/shared/config/database.yml"
UPLOADS_DIR="$APP_DIR/shared/system"
DB_NAME=""

echo "=== deployvzs pre-flight check ==="
echo "    $(date)"
echo "    $(whoami)@$(hostname)"
echo ""

# --- 1. Running as correct user ---
echo "-- User & access --"
if [ "$(whoami)" = "deployvzs" ]; then
    pass "Running as deployvzs"
else
    fail "Running as $(whoami), expected deployvzs"
fi

# --- 2. App directory exists ---
echo ""
echo "-- App directory --"
if [ -d "$APP_DIR" ]; then
    pass "App directory exists: $APP_DIR"
else
    fail "App directory missing: $APP_DIR"
fi

# --- 3. Database config ---
echo ""
echo "-- Database config --"
if [ -f "$DB_CONFIG" ]; then
    pass "database.yml exists: $DB_CONFIG"
else
    fail "database.yml missing: $DB_CONFIG"
fi

if [ -f "$DB_CONFIG" ]; then
    DB_NAME=$(grep -A 10 '^production:' "$DB_CONFIG" | grep 'database:' | head -1 | awk '{print $2}')
    DB_USER=$(grep -A 10 '^production:' "$DB_CONFIG" | grep 'username:' | head -1 | awk '{print $2}')
    DB_PASS=$(grep -A 10 '^production:' "$DB_CONFIG" | grep 'password:' | head -1 | awk '{print $2}')

    if [ -n "$DB_NAME" ]; then
        pass "Production DB name found: $DB_NAME"
    else
        fail "Could not parse production database name from database.yml"
    fi

    if [ -n "$DB_USER" ]; then
        pass "Production DB username found: $DB_USER"
    else
        fail "Could not parse production username from database.yml"
    fi

    if [ -n "$DB_PASS" ]; then
        pass "Production DB password found (not empty)"
    else
        fail "Could not parse production password from database.yml"
    fi

    if [ -n "$DB_NAME" ] && [ -n "$DB_USER" ] && [ -n "$DB_PASS" ]; then
        pass "All credentials parsed (db=$DB_NAME user=$DB_USER)"
    else
        fail "Incomplete credentials — backup-sync will abort"
    fi
fi

# --- 4. MySQL accessible & database exists ---
echo ""
echo "-- MySQL --"
if command -v mysqldump &>/dev/null; then
    pass "mysqldump is available"
else
    fail "mysqldump not found in PATH"
fi

if command -v mysql &>/dev/null; then
    pass "mysql client is available"
else
    fail "mysql client not found in PATH"
fi

if [ -n "${DB_USER:-}" ] && [ -n "${DB_PASS:-}" ]; then
    if mysql -u"$DB_USER" -p"$DB_PASS" -e "SELECT 1" "$DB_NAME" &>/dev/null; then
        pass "Can connect to database: $DB_NAME"
        ROW_COUNT=$(mysql -u"$DB_USER" -p"$DB_PASS" -N -e "SELECT COUNT(*) FROM users" "$DB_NAME" 2>/dev/null || echo "")
        if [ -n "$ROW_COUNT" ] && [ "$ROW_COUNT" -gt 0 ]; then
            pass "Database has data ($ROW_COUNT users)"
        else
            warn "Database appears empty or users table missing"
        fi
    else
        fail "Cannot connect to database $DB_NAME with parsed credentials"
    fi

    # Test mysqldump actually works
    if mysqldump --single-transaction --add-drop-table -u"$DB_USER" -p"$DB_PASS" "$DB_NAME" --no-data &>/dev/null; then
        pass "mysqldump works with --single-transaction"
    else
        fail "mysqldump failed — check credentials or permissions"
    fi
fi

# --- 5. Paperclip uploads directory ---
echo ""
echo "-- Uploads (Paperclip) --"
if [ -d "$UPLOADS_DIR" ]; then
    pass "Uploads directory exists: $UPLOADS_DIR"
    FILE_COUNT=$(find "$UPLOADS_DIR" -type f | wc -l)
    DIR_SIZE=$(du -sh "$UPLOADS_DIR" 2>/dev/null | cut -f1)
    pass "Uploads: $FILE_COUNT files, $DIR_SIZE total"
else
    fail "Uploads directory missing: $UPLOADS_DIR"
fi

if [ -r "$UPLOADS_DIR" ]; then
    pass "Uploads directory is readable"
else
    fail "Uploads directory is not readable"
fi

# --- 6. SSH authorized_keys (for incoming connection from Hetzner) ---
echo ""
echo "-- SSH (incoming from Hetzner) --"
AUTH_KEYS="$HOME/.ssh/authorized_keys"
if [ -f "$AUTH_KEYS" ]; then
    KEY_COUNT=$(wc -l < "$AUTH_KEYS")
    pass "authorized_keys exists ($KEY_COUNT keys)"
else
    warn "No authorized_keys — Hetzner won't be able to SSH in without password"
fi

# --- 7. rsync available (used by backup-sync for uploads) ---
echo ""
echo "-- Tools --"
if command -v rsync &>/dev/null; then
    pass "rsync is available"
else
    fail "rsync not found — needed for upload sync"
fi

if command -v gzip &>/dev/null; then
    pass "gzip is available"
else
    fail "gzip not found"
fi

# --- Summary ---
echo ""
echo "=== Summary ==="
echo "    Passed: $PASS"
echo "    Failed: $FAIL"
echo "    Warnings: $WARN"
echo ""
if [ "$FAIL" -eq 0 ]; then
    echo "All checks passed. Ready for backup-sync."
else
    echo "Fix the failures above before running backup-sync.sh"
fi
exit "$FAIL"
