function _fzf-git-log
    git rev-parse HEAD &>/dev/null; or return
    set -f lines (git log --date=short --color=always \
        --format='%C(green)%C(bold)%cd %C(auto)%h%d %s (%an)' \
        | fzf --ansi --layout=reverse --multi \
        --preview='git show --color=always --stat --patch {2}')

    if test $status -eq 0
        for line in $lines
            set -f hash (string split --field 2 " " $line)
            set -f --append hashes $hash
        end
        commandline --current-token --replace (string join ' ' $hashes)
    end

    commandline --function repaint
end
