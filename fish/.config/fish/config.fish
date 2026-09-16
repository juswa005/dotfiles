if status is-interactive
    # Commands to run in interactive sessions can go here
    alias frieren="fastfetch -c ~/.config/fastfetch/frieren.jsonc"
    alias c="clear"
    alias l="ls -l"
    function agc
        agy --conversation=$argv[1]
    end
    zoxide init fish | source
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/amiel/.lmstudio/bin
# End of LM Studio CLI section


# opencode
fish_add_path /home/amiel/.opencode/bin
