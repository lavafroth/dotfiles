set fish_greeting
set --universal --export GOPATH "$HOME/Public/go"
set -U           -x      GOBIN "$GOPATH/bin"

# Run the following only once for it to take effect.
# fish_add_path --append --path --move $GOBIN
# alias --save l='exa -lah'
# alias --save cat='bat -p'

if status is-interactive
    # Commands to run in interactive sessions can go here
end
