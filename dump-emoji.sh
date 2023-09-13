#!/bin/bash

EMOJI_JSON=emoji_$(date +%Y%m%d).json
EMOJI_DIR=data

if [ ! -f "$EMOJI_JSON" ]; then
    if [ -z "$1" ]; then
        echo "Usage: $0 <bot_token>"
        echo "  To get a bot token, create a slack app with emoji:read privilege and install it into your slack workspace."
        exit 2
    fi
    curl -H 'Accept: application/json' -H "Authorization: Bearer $1" 'https://slack.com/api/emoji.list?pretty=1' -L -o "$EMOJI_JSON"
else
    echo "Emoji list already found!"
fi

mkdir -p "$EMOJI_DIR"

urldecode() {
    echo -e "${*//%/\\x}"
}

urls=$(jq -r '.emoji[]' < "$EMOJI_JSON" | grep '^https')
echo "$(echo "$urls" | wc -l) emojis listed"
for url in $urls; do
    raw_name=$(echo $url | sed 's_.*/\([^/]*\)/[^/]*\.\([^/.]*\)$_\1.\2_')
    name=$(urldecode $(urldecode $raw_name))
    
    if [ ! -f "$EMOJI_DIR/$name" ]; then
        curl -s -L -o "$EMOJI_DIR/$name" "$url"
        printf "."
    fi
done
