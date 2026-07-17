if status is-interactive
    # Commands to run in interactive sessions can go here
    alias frieren="fastfetch -c ~/.config/fastfetch/frieren.jsonc"
    function agc
        agy --conversation=$argv[1]
    end
end

# Added by LM Studio CLI (lms)
set -gx PATH $PATH /home/amiel/.lmstudio/bin
# End of LM Studio CLI section

