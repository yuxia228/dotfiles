# tmptmux 用設定: 通常設定に加え、他の tmux server への移動キーを無効化する
source-file ~/.tmux.conf
unbind-key -n F10
unbind-key -n M-s
unbind-key S
unbind-key -n M-1
unbind-key -n M-2
unbind-key -n M-3
unbind-key -n M-4
unbind-key -n M-5
unbind-key -n M-6
unbind-key -n M-7
unbind-key -n M-8
unbind-key -n M-9

# status-left から tmx のサーバー一覧を除く
STATUS_BOX="#{?#{window_zoomed_flag},#[bg=colour1]Zoomed,#[bg=colour4]Normal}#[default]"
STATUS_BOX="#{?pane_synchronized,#[bg=colour5]Synced,${STATUS_BOX}}#[default]"
set-option -g status-left "$STATUS_BOX #[fg=colour255,bg=colour241] #(get_ip_tmux) #[default]"
