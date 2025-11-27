#!/usr/bin/bash

# move into the folder directory
cd /home/vagrant/memory_usage/

# create log file if it does not exist
touch memory_usage.log

# append date to log file
date >> memory_usage.log

# append memory usage to log file
free -h >> memory_usage.log

# create a function to send mail
function send_mail() {
    local recipient="$1"
    local subject="Memory Usage Log"
    local body=$(cat memory_usage.log)
    echo -e "$body" | mail -s "$subject" "$recipient"
}

# get current time
current_time=$(date +"%I:%M %p")

# create a condition to send a mail at mid night
if [[ "$current_time" == "12:00 AM" ]]; then
    send_mail "$1"
    rm memory_usage.log
else
    echo "********************DONE********************" >> memory_usage.log
    echo " " >> memory_usage.log
fi
