if status is-interactive
    # Commands to run in interactive sessions can go here
end

set fish_greeting

fish_add_path --path "$HOME/.cargo/bin"
fish_add_path --path "/opt/flutter/bin"
fish_add_path --path "$ANDROID_HOME/tools"
fish_add_path --path "$ANDROID_HOME/tools/bin"
fish_add_path --path "$ANDROID_HOME/platform-tools"

set -U CHROME_EXECUTABLE /bin/google-chrome
set -U ANDROID_HOME $HOME/Android/Sdk
