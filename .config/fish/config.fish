if status is-interactive
    set -g fish_greeting
    # Commands to run in interactive sessions can go here
    if not set -q TMUX
        set -g TMUX tmux new-session
        eval $TMUX
        tmux attach-session
    end
    fish_config theme choose "RosePineDawn"
    zoxide init fish | source
    starship init fish | source
end
