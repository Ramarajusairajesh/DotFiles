if status is-interactive

end

test -s ~/.config/envman/load.fish; and source ~/.config/envman/load.fish

function nvim_preview --argument file
    nvim -c "set nomodifiable" -c "set readonly" -c "set nonumber" -c "set foldmethod=manual" -c "set syntax=on" -c "normal gg100G" $file
end

function preview_file --argument file
    if test -d "$file"
        ls -A --color=always "$file"
    else if command -v bat >/dev/null 2>&1
        bat --style=numbers --color=always --line-range=:100 "$file"
    else
        head -n 100 "$file"
    end
end

function search_home
    set file (fd . /home --hidden --follow --exclude .cache | fzf --preview "preview_file {}" --bind 'ctrl-o:execute(nvim {})+abort')

    if test -n "$file"
        if test -d "$file"
            cd "$file"
        else
            cd (dirname -- "$file")
        end
    end
end

function search_root
    set file (fd . / --hidden --follow | fzf --preview "preview_file {}" --bind 'ctrl-o:execute(nvim {})+abort')

    if test -n "$file"
        if test -d "$file"
            cd "$file"
        else
            cd (dirname -- "$file")
        end
    end
end

function search_current
    set file (fd . . --hidden --follow | fzf --preview "preview_file {}" --bind 'ctrl-o:execute(nvim {})+abort')

    if test -n "$file"
        if test -d "$file"
            cd "$file"
        else
            cd (dirname -- "$file")
        end
    end
end

function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if set cwd (command cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# Bind ALT + Space for /home search
bind \e\x20 search_current

# Bind ALT + / for root search
bind \e/ search_root

# Bind Alt + c for current directory search.
bind \ec search_home

#Terminal file emulator
bind \co y
#Nvim temp directory for caching 
set -Ux TMPDIR $HOME/.cache/nvim_tmp
mkdir -p $TMPDIR
