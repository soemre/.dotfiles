#!/bin/bash

readonly status=$(playerctl metadata --player=spotify --format "{{status}}")
readonly text=$(playerctl metadata --player=spotify --format "{{title}}  {{artist}}")
readonly tooltip=$(playerctl metadata --player=spotify --format "{{duration(position)}} - {{duration(mpris:length)}}\n{{artist}}\n{{title}}\n{{album}}")

echo "{ \"class\": \"$status\", \"text\": \"$text\", \"tooltip\": \"$tooltip\" }"
