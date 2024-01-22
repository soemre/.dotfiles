# Link Wallpaper
readonly wallpapers_dir="${HOME}/wallpapers"

echo -e "$TAG_STATUS Seting up the default wallpaper..."

if ! [ -d "$wallpapers_dir" ]
then
    mkdir "$wallpapers_dir"

    echo -e "$TAG_DONE Created: $wallpapers_dir"
fi

if [ -L "${wallpapers_dir}/default_wallpaper.jpg" ]
then
    echo -e "$TAG_SKIP The default wallpaper is already linked."
else
    ln -s "$ABSOLUTE_PATH/misc/default_wallpaper.jpg" "$wallpapers_dir"
    echo -e "$TAG_DONE The default wallpaper has been linked."
fi
