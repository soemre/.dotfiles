$env.config = {
    show_banner: false
}

# zoxide
zoxide init nushell | save -f ~/.zoxide.nu
source ~/.zoxide.nu

# starship
mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")
