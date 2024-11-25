status is-interactive || exit

function _fzf-git-fish-key-bindings --on-variable fish_key_bindings
    set -l modes
    if test "$fish_key_bindings" = fish_default_key_bindings
        set modes default insert
    else
        set modes insert default
    end

    bind --mode $modes[1] \cg\cb _fzf-git-branches
    bind --mode $modes[1] \cg\cl _fzf-git-log
    bind --mode $modes[1] \cg\ct _fzf-git-tags
end

_fzf-git-fish-key-bindings

function _fzf-git-uninstall --on-event fzf-git_uninstall
    string collect (
    bind --all | string replace --filter --regex -- "_fzf-git.*" --erase
    ) | source
    functions --erase (functions --all | string match "_fzf-git-*")
end
