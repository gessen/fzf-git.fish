function _fzf-git-branches
    git rev-parse HEAD &>/dev/null; or return
    set -f lines (git branch --all --color=always --format='%(refname:short)' \
        | fzf --ansi --layout=reverse --tac --multi --preview-window 66% \
        --preview='git log --oneline --date=short --color=always {1}')

    if test $status -eq 0
        for line in $lines
            set -f branch (string split --field 1 ' ' $line)
            set -f --append branches $branch
        end
        commandline --current-token --replace (string join ' ' $branches)
    end

    commandline --function repaint
end
