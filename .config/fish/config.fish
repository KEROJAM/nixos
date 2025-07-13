if status is-interactive
    set -g fish_greeting
    # Commands to run in interactive sessions can go here
    #if not set -q TMUX
    #    set -g TMUX tmux new-session
    #    eval $TMUX
    #    tmux attach-session
    #end
    if test -z (pgrep ssh-agent)
        eval (ssh-agent -c)
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
        set -Ux SSH_AGENT_PID $SSH_AGENT_PID
        set -Ux SSH_AUTH_SOCK $SSH_AUTH_SOCK
    end
    zoxide init fish | source
    starship init fish | source
    direnv hook fish | source
    alias rm="trash -v"
end
