# ── Environment Variables
set -gx EDITOR nvim
set -gx STARSHIP_CONFIG "$HOME/.config/starship/starship.toml"
# set -gx OMO_SEND_ANONYMOUS_TELEMETRY 0
# set -gx CLAUDE_CODE_EXPERIMENTAL_AGENT_TEAMS 1

# ~/.config/fish/config.fish
starship init fish | source

# ── PATH
fish_add_path ~/.local/bin

    # ── Abbreviations

    # General
    abbr -a e exit
    abbr -a c clear
    abbr -a v nvim
    abbr -a lg lazygit
    abbr -a py python 
    abbr -a disk 'smartctl -a (diskutil list | awk \'/internal\)/{print $1; exit}\' | sed \'s|/dev/||\')'
    abbr -a copy pbcopy
    abbr -a ports 'lsof -i -P | grep -i "listen"'
    abbr -a ff fastfetch
    abbr -a open 'xdg-open'
    abbr -a ll "ls -l"
    abbr -a update-grub 'sudo grub-mkconfig -o /boot/grub/grub.cfg'
    abbr -a update-kernel 'sudo mkinitcpio -P'
    # pacman & yay
    abbr -a pcs "sudo pacman -S"
    abbr -a pcss "sudo pacman -Ss"
    abbr -a pcu "sudo pacman -Syu"
    abbr -a pcqs "pacman -Qs"
    abbr -a pcrns "sudo pacman -Rns"
    abbr -a pcrnsq 'sudo pacman -Rns $(pacman -Qdtq)'
    abbr -a pcc "sudo pacman -Sc"
    abbr -a pccc "sudo pacman -Scc"
    abbr -a yu "yay -Syu"
    abbr -a ys "yay -S"
    abbr -a yss "yay -Ss"
    abbr -a pcql "pacman -Ql"

       # Tmux
    abbr -a ts 'tmux source-file ~/.config/tmux/tmux.conf'
    abbr -a tls 'tmux ls'
    abbr -a tn 'tmux new -s'
    abbr -a tk 'tmux kill-session -t'
    abbr -a ta 'tmux attach'
    abbr -a trw 'tmux rename-window'
    abbr -a trs 'tmux rename-session'
    # Yazi
    abbr -a yau 'ya pkg upgrade'
    abbr -a yaa 'ya pkg add'
    abbr -a yad 'ya pkg delete'
    abbr -a yal 'ya pkg list'

    # Eza
    abbr -a el 'eza --long --header --icons --git --all'
    abbr -a et 'eza --tree --level=2 --long --header --icons --git'

    # ── FZF
    set -gx FZF_DEFAULT_OPTS "\
    --height 75% \
    --layout=reverse \
    --border \
    --info=inline"

    set -g fzf_fd_opts "--hidden --follow --exclude .git"
    set -g fzf_preview_dir_cmd eza --all --color=always --icons --git --tree --level=2
    set -g fzf_preview_file_cmd bat --style=numbers --color=always --line-range :500
    set -g fzf_diff_highlighter "delta --paging=never --features='mellow-barbet' --syntax-theme='Catppuccin Mocha'"
    set -g fzf_history_time_format %d-%m-%y


    #function
    function fish_greeting
	    random choice "Hi Annoy!"
    end
    function p
        cd ~/Projects/
    end
    function d
        cd ~/Downloads/
    end
    function s 
        cd ~/study/
    end
    function doc 
        cd ~/Documents/
    end
