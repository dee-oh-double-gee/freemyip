#!/bin/bash
#copy in your freemyip.com url with token and domain and MAKE SURE you add the &verbose=yes at the end
url="https://freemyip.com/update?token=YOUR_TOKEN&domain=YOUR_DOMAIN.freemyip.com&verbose=yes"

keyword="didn't change"

if curl -s "$url" | grep -q "$keyword"
then
        echo "No update"
else
    domain=$(echo "$url" | grep -o -P '(?<=domain=).*(?=freemyip.com&)')
    echo "IP updated for ${domain}freemyip.com"

    APP_TOKEN="APPTOKENHERE"
    USER_TOKEN="USERTOKENHERE"
    MESSAGE="IP updated for ${domain}freemyip.com"
    TITLE="IP update"
    wget https://api.pushover.net/1/messages.json --post-data="token=$APP_TOKEN&user=$USER_TOKEN&message=$MESSAGE&title=$TITLE" -qO- > /dev/null 2>&1 &
fi
