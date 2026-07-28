export PATH="/opt/homebrew/opt/llvm/bin:/opt/homebrew/bin:$PATH"
export EDITOR=nvim
export PS1="%2~ %(1j.%F{red}%B%j%f%b.)%m%# "

alias gs="git status"
alias gc="git commit"
alias kps="keepassxc-cli"
alias gcc="gcc-15"

freeze() {
    local src out

    if (( $# == 0 )); then
        echo "Usage: freeze <file|dir> [...]"
        return 1
    fi

    for src in "$@"; do
        out="${src:t}.tar.gz.age"
        tar -czf - "$src" \
            | age -R ~/.age.key.pub -o "$out"
    done
}

thaw() {
    local infile outdir base

    if (( $# == 0)); then
        echo "Usage: thaw <*.tar.gz.age> [...]"
        return 1
    fi

    for infile in "$@"; do
        if [[ "$infile" != *.tar.gz.age ]]; then
            echo "Skipping $infile (arguments must match pattern *.tar.gz.age)"
            continue
        fi

        age -d -i ~/.age.key "$infile" | tar -xzf - -C .
    done
}

notes() {
    nvim $NOTES_DIR
}

[ -f ~/.env ] && . ~/.env
