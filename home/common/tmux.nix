{...}: {
  # tmux
  # TODO: change to use home-manager
  programs.tmux.enable = true;
  programs.tmux.baseIndex = 1;
  programs.tmux.extraConfig = ''
    set -g history-limit 30000
    set -g mouse on
    unbind C-b
    set -g prefix C-a
    setw -g mode-keys vi
    bind C-a send-prefix
    set -g base-index 1
    set -g pane-base-index 1

    bind '\' split-window -h
    bind '-' split-window -v
    bind r source-file ~/.config/tmux/tmux.conf \; display "Configuration reloaded from home"

    # Kill pane without confirm
    bind-key x kill-pane

    set-option -g default-terminal "screen-256color"
    set-option -g renumber-windows on
    set -s escape-time 0

    # theme colors
    RED=#f07167
    GRAY=#6E6A6F
    GREEN=#c8E9A0
    LAVENDER=#dad4ef
    GRAY_BG=#001524
    GRAY_LIGHTER=#1c1d21
    YELLOW=#E4B363
    SOFT_LILAC=#C5A3FF
    ICY_BLUE=#A5C3DD
    MINT_GREEN=#98D7C2
    SKY_BLUE=#78A7D6

    DARK_BG=#121212
    TEXT_FG=#625a5a


    # theme
    name="#[fg=$SOFT_LILAC]#(whoami)"
    at="#[fg=$GRAY] @ "
    hostname="#[fg=$LAVENDER]#H"
    set -g status-left "''${name}''${at}''${hostname} "
    set -g status-left-style fg=#FF5F00,bold,bg=$GRAY_BG
    set -g status-left-length 40

    set -g window-status-current-style fg=$SKY_BLUE,bold,bg=$GRAY_LIGHTER
    set -g window-status-current-format "#{?window_last_flag, , }#{?window_zoomed_flag,[,}#I:#W#{?window_zoomed_flag,],}#{?window_last_flag, , }"
    set -g window-status-format "#{?window_last_flag, , }#{?window_zoomed_flag,[,}#I:#W#{?window_zoomed_flag,],}#{?window_last_flag, , }"

    set -g status-style fg=$TEXT_FG,bg=$DARK_BG
    set -g status-right-length 2001
    # #h hostshort , #S session , #W window , #T pane name
    wg_prfx=" #[fg=green,bg=default]#{?client_prefix,<C-a>,} "  # prefix indicator widget
    wg_date="#[fg=$ICY_BLUE,bold,bg=default] %d-%m-%Y #[fg=$MINT_GREEN](%B)#[bg=none] "
    wg_time=" #[fg=$LAVENDER,bold]%H:%M#[none]"
    system_info="#[fg=default]#(bash ~/.scripts/sys_usage.sh)"
    set -g status-right "''${wg_prfx}''${system_info}''${wg_time}''${wg_date}"
    # }}}

    # Pane theme stuff
    set -g pane-border-style fg=$LAVENDER
    set -g pane-active-border-style "bg=default fg=$RED"

    bind -n M-1 select-window -t 1
    bind -n M-2 select-window -t 2
    bind -n M-3 select-window -t 3
    bind -n M-4 select-window -t 4
    bind -n M-5 select-window -t 5
    bind -n M-6 select-window -t 6
    bind -n M-7 select-window -t 7
    bind -n M-8 select-window -t 8
    bind -n M-9 select-window -t 9

    # Redraw status every second
    set-option -g status-interval 1

    # vim binds goodness
    bind h select-pane -L
    bind j select-pane -D
    bind k select-pane -U
    bind l select-pane -R

    bind-key -n C-q next-window
    bind-key -n C-p previous-window
    set -g mouse on

  '';
}
