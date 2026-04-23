if status is-interactive
    atuin init fish --disable-up-arrow | source
    thefuck --alias | source
end

set fish_greeting
zoxide init fish | source

fish_add_path -aP $HOME/.pub-cache/bin
