if status is-interactive
    set -g fish_greeting
    set -Ux EDITOR 'nvim'
    set -Ux TERMINAL 'ghostty'
    # Commands to run in interactive sessions can go here
    #
    eval (zellij setup --generate-auto-start fish | string collect)
    eval (ssh-agent -c | head -n2)
    zoxide init fish | source
    starship init fish | source
    direnv hook fish | source
    alias rm="trash -v"
end
