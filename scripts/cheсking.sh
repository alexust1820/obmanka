#!/bin/bash

PREVIOUS_HOSTS_FILE="/var/log/previous_hosts.txt"
LOG_FILE="/var/log/new_hosts.log"
REMOVED_HOSTS_LOG_FILE="/var/log/removed_hosts.log"

get_current_hosts() {
    ipa host-find | grep "Имя узла" | awk -F: '{print $2}' | tr -d ' '
}

if [ ! -f "$PREVIOUS_HOSTS_FILE" ]; then
    get_current_hosts > "$PREVIOUS_HOSTS_FILE"
    echo "Создан начальный список узлов."
    exit 0
fi

current_hosts=$(get_current_hosts)
previous_hosts=$(cat "$PREVIOUS_HOSTS_FILE")

new_hosts=$(comm -13 <(echo "$previous_hosts" | sort) <(echo "$current_hosts" | sort))

removed_hosts=$(comm -23 <(echo "$previous_hosts" | sort) <(echo "$current_hosts" | sort))

if [ ! -z "$new_hosts" ]; then
    echo "Новые узлы найдены: $new_hosts"
    echo "$(date '+%Y-%m-%d %H:%M:%S') Новые узлы: $new_hosts" >> "$LOG_FILE"
fi

if [ ! -z "$removed_hosts" ]; then
    echo "Удаленные узлы найдены: $removed_hosts"
    echo "$(date '+%Y-%m-%d %H:%M:%S') Удаленные узлы: $removed_hosts" >> "$REMOVED_HOSTS_LOG_FILE"
fi

echo "$current_hosts" > "$PREVIOUS_HOSTS_FILE"