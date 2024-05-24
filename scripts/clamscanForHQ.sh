USERS_TO_CHECK=("admin" "network_admin" "branch_admin" "user" "root" "net_admin" "br_admin" "adm")

LOG_DIR="/var/log/clamav"
mkdir -p $LOG_DIR

LOG_FILE="$LOG_DIR/daily_clamscan_$(date +'%Y-%m-%d_%H-%M').log"

all_users_inactive=true

for USER_TO_CHECK in "${USERS_TO_CHECK[@]}"; do
    USER_PROCESS_COUNT=$(ps -u $USER_TO_CHECK | grep -v "PID" | wc -l)
    if [ $USER_PROCESS_COUNT -gt 200 ]; then
        all_users_inactive=false
        break
    fi
done

if [ "$all_users_inactive" = true ]; then
    nice -n 19 clamscan -r / --quiet --exclude-dir="^/sys" --exclude-dir="^/proc" --exclude-dir="^/dev" --log=$LOG_FILE
fi
