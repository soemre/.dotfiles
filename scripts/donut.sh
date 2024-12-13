#!/bin/bash

path="$HOME/.local/share/scripts/donut.py" 
link="/usr/local/bin/donut" 

if ! [ -s "$link" ]; then
    set -e
    ln -s "$(realpath "$0")" "$link"
    set +e
fi

if ! [ -f "$path" ]; then
    mkdir -p "${path%/*}/"
    curl https://raw.githubusercontent.com/EvanZhouDev/TheDonutProject/4d99ac7b9a28c861294a7fce3371572491072db8/donuts/donut.py >"$path" 2>/dev/null
fi

python3 "$path" 2>/dev/null
