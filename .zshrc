export PATH="/opt/homebrew/bin:$PATH"
export EDITOR=nvim
export PS1="%2~ %(1j.%F{red}%B%j%f%b.)%m%# "

alias gs="git status"
alias gc="git commit"

earchive() {
    local src out

    if (( $# == 0 )); then
        echo "Usage: earchive <file|dir> [...]"
        return 1
    fi

    for src in "$@"; do
        out="${src:t}.tar.gz.age"
        tar -czf - "$src" \
            | age -R ~/.age.key.pub -o "$out"
    done
}

unearchive() {
    local infile outdir base

    if (( $# == 0)); then
        echo "Usage: unearchive <*.tar.gz.age> [...]"
        return 1
    fi

    for infile in "$@"; do
        if [[ "$infile" != *.tar.gz.age ]]; then
            echo "Skipping $infile (arguments must match pattern  *.tar.gz.age)"
            continue
        fi

        base="${infile:t}"
        outdir="${base%.tar.gz.age}"

        mkdir -p "$outdir"
        age -d -i ~/.age.key "$infile" \
            | tar -xzf - -C "$outdir"
    done
}

log() {
    nvim ~/Desktop/log
}

[ -f ~/.env ] && . ~/.env
